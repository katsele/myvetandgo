import { unauthorized } from 'next/navigation';
import { getAppSession } from './server';
import { hasPermission, type Permission } from './permissions';
import type { UserRole } from '@/lib/generated/prisma/client';

export async function requireAuth() {
  const session = await getAppSession();
  if (!session) unauthorized();
  return session;
}

export async function requireRole(...roles: UserRole[]) {
  const session = await requireAuth();
  if (session.appUser.role !== 'ADMIN' && !roles.includes(session.appUser.role))
    unauthorized();
  return session;
}

export async function requirePermission(permission: Permission) {
  const session = await requireAuth();
  if (!hasPermission(session.appUser.role, permission)) unauthorized();
  return session;
}
