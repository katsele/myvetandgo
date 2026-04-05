import { createAuthServer, neonAuth } from '@neondatabase/auth/next/server';
import { db } from '@/lib/db';

export const authServer = createAuthServer();

/**
 * Resolves the Neon Auth session into the full app User with role, org, etc.
 * Returns null if not authenticated or no linked app user found.
 */
export async function getAppSession() {
  const { session, user } = await neonAuth();
  if (!session || !user) return null;

  const appUser = await db.user.findUnique({
    where: { neonAuthId: user.id },
    include: { organization: true },
  });

  if (!appUser) return null;

  return { session, neonUser: user, appUser };
}
