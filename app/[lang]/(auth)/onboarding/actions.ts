'use server';

import { redirect } from 'next/navigation';
import { db } from '@/lib/db';
import { getAppSession } from '@/lib/auth/server';
import type { Country, Language } from '@/lib/generated/prisma/client';

export async function completeOnboarding(
  _prev: { error?: string } | null,
  formData: FormData
) {
  const session = await getAppSession();
  if (!session) return { error: 'Not authenticated' };

  const firstName = formData.get('firstName') as string;
  const lastName = formData.get('lastName') as string;
  const language = formData.get('language') as Language;
  const country = formData.get('country') as Country;

  if (!firstName?.trim() || !lastName?.trim()) {
    return { error: 'Prénom et nom sont requis' };
  }

  await db.user.update({
    where: { id: session.appUser.id },
    data: {
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      language,
      country,
      onboarded: true,
    },
  });

  redirect(`/${language === 'NL' ? 'nl' : 'fr'}/dashboard`);
}
