import { redirect } from 'next/navigation';
import { requireAuth } from '@/lib/auth/guards';

export default async function PlatformLayout({
  children,
  params,
}: Readonly<{
  children: React.ReactNode;
  params: Promise<{ lang: string }>;
}>) {
  const { lang } = await params;
  const { appUser } = await requireAuth();

  if (!appUser.onboarded) {
    redirect(`/${lang}/onboarding`);
  }

  return <>{children}</>;
}
