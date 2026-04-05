import Link from 'next/link';
import { headers } from 'next/headers';

const SUPPORTED_LOCALES = ['fr', 'nl'] as const;
const DEFAULT_LOCALE = 'fr';

const messages = {
  fr: {
    title: '401 — Non autorisé',
    message: 'Veuillez vous connecter pour accéder à cette page.',
    login: 'Se connecter',
  },
  nl: {
    title: '401 — Niet geautoriseerd',
    message: 'Log in om deze pagina te bekijken.',
    login: 'Inloggen',
  },
} as const;

export default async function UnauthorizedPage() {
  const headersList = await headers();
  const pathname = headersList.get('x-next-url') ?? '';
  const segment = pathname.split('/')[1];
  const lang =
    segment && SUPPORTED_LOCALES.includes(segment as (typeof SUPPORTED_LOCALES)[number])
      ? (segment as (typeof SUPPORTED_LOCALES)[number])
      : DEFAULT_LOCALE;

  const t = messages[lang];

  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-4">
      <h1 className="text-2xl font-bold">{t.title}</h1>
      <p>{t.message}</p>
      <Link
        href={`/${lang}/login`}
        className="rounded bg-blue-600 px-4 py-2 text-white hover:bg-blue-700"
      >
        {t.login}
      </Link>
    </main>
  );
}
