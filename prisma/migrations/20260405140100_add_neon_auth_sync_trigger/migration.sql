-- Sync trigger: neon_auth.user -> public.User
-- When a user signs up via Neon Auth, auto-create or link an app User row.
-- ON CONFLICT handles invitation flow: admin pre-creates User with email,
-- trigger links it via neonAuthId on actual signup.

CREATE OR REPLACE FUNCTION sync_neon_auth_user()
RETURNS TRIGGER AS $$
DECLARE
  _org_id text;
BEGIN
  SELECT id INTO _org_id FROM public."Organization" WHERE slug = 'vetandgo' LIMIT 1;

  IF _org_id IS NULL THEN
    RAISE EXCEPTION 'sync_neon_auth_user: Organization with slug "vetandgo" not found. Seed the database before enabling signups.';
  END IF;

  INSERT INTO public."User" (id, "neonAuthId", email, "firstName", "lastName", "organizationId")
  VALUES (
    gen_random_uuid()::text,
    NEW.id,
    NEW.email,
    COALESCE(split_part(NEW.name, ' ', 1), ''),
    COALESCE(split_part(NEW.name, ' ', 2), ''),
    _org_id
  )
  ON CONFLICT (email) DO UPDATE SET "neonAuthId" = NEW.id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_neon_auth_user_created
  AFTER INSERT ON neon_auth."user"
  FOR EACH ROW
  EXECUTE FUNCTION sync_neon_auth_user();
