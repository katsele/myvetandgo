import { AuthProvider } from '@/components/auth/auth-provider';

export default async function LangLayout({
  children,
  params,
}: LayoutProps<'/[lang]'>) {
  const { lang } = await params;

  return <AuthProvider lang={lang}>{children}</AuthProvider>;
}
