import { NextRequest, NextResponse } from 'next/server';

const SUPPORTED_LOCALES = ['fr', 'nl'];
const DEFAULT_LOCALE = 'fr';
const PUBLIC_PATHS = ['/login', '/signup', '/verify', '/forgot-password'];
const NEON_AUTH_COOKIE_PREFIX = '__Secure-neon-auth';

export function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Skip static files and auth API routes
  if (
    pathname.startsWith('/_next') ||
    pathname.startsWith('/api/auth') ||
    pathname === '/favicon.ico'
  ) {
    return NextResponse.next();
  }

  // Locale detection: extract [lang] from path
  const segments = pathname.split('/');
  const maybeLang = segments[1];

  if (!SUPPORTED_LOCALES.includes(maybeLang)) {
    const locale = detectLocale(request);
    const redirectUrl = new URL(`/${locale}${pathname}`, request.url);
    redirectUrl.search = request.nextUrl.search;
    return NextResponse.redirect(redirectUrl);
  }

  // Auth check for non-public routes
  const pathWithoutLang = '/' + segments.slice(2).join('/');
  const isPublicPath =
    pathWithoutLang === '/' ||
    PUBLIC_PATHS.some(
      (p) => pathWithoutLang === p || pathWithoutLang.startsWith(p + '/')
    );

  if (!isPublicPath) {
    const hasSession = Array.from(request.cookies.getAll()).some((c) =>
      c.name.startsWith(NEON_AUTH_COOKIE_PREFIX)
    );
    if (!hasSession) {
      const loginUrl = new URL(`/${maybeLang}/login`, request.url);
      loginUrl.searchParams.set('callbackUrl', pathname);
      return NextResponse.redirect(loginUrl);
    }
  }

  const response = NextResponse.next();
  response.headers.set('x-next-url', pathname);
  return response;
}

function detectLocale(request: NextRequest): string {
  // Check cookie preference first
  const cookieLocale = request.cookies.get('locale')?.value;
  if (cookieLocale && SUPPORTED_LOCALES.includes(cookieLocale)) {
    return cookieLocale;
  }

  // Fall back to Accept-Language header
  const acceptLang = request.headers.get('accept-language') ?? '';
  for (const locale of SUPPORTED_LOCALES) {
    if (acceptLang.includes(locale)) return locale;
  }

  return DEFAULT_LOCALE;
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
};
