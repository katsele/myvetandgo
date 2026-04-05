import { AuthView } from '@neondatabase/auth/react/ui';
import { authViewPaths } from '@neondatabase/auth/react/ui/server';

export const dynamicParams = false;

export function generateStaticParams() {
  return [{ lang: 'fr' }, { lang: 'nl' }];
}

export default async function LoginPage() {
  return (
    <main className="flex flex-col items-center gap-6">
      <h1 className="text-2xl font-bold">My Vet&amp;Go</h1>
      <AuthView path={authViewPaths.SIGN_IN} />
    </main>
  );
}
