'use client';

import { NeonAuthUIProvider } from '@neondatabase/auth/react/ui';
import { authClient } from '@/lib/auth/client';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import type { ReactNode } from 'react';

export function AuthProvider({
  children,
  lang,
}: {
  children: ReactNode;
  lang: string;
}) {
  const router = useRouter();

  return (
    <NeonAuthUIProvider
      authClient={authClient}
      navigate={router.push}
      replace={router.replace}
      onSessionChange={() => router.refresh()}
      redirectTo={`/${lang}/dashboard`}
      Link={Link}
      credentials={{ forgotPassword: true }}
      emailOTP
      signUp={{ fields: ['name'] }}
    >
      {children}
    </NeonAuthUIProvider>
  );
}
