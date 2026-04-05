import type { UserRole } from '@/lib/generated/prisma/client';

export type Permission =
  | 'view:own-progress'
  | 'view:org-users'
  | 'manage:org-users'
  | 'view:child-orgs'
  | 'manage:content'
  | 'admin:platform';

const ROLE_PERMISSIONS: Record<UserRole, Permission[]> = {
  VET: ['view:own-progress'],
  ASV: ['view:own-progress'],
  MANAGER: ['view:own-progress', 'view:org-users', 'manage:org-users'],
  GROUP_ADMIN: [
    'view:own-progress',
    'view:org-users',
    'manage:org-users',
    'view:child-orgs',
  ],
  CONTRIBUTOR: ['view:own-progress', 'manage:content'],
  ADMIN: [],
};

export function hasPermission(role: UserRole, permission: Permission): boolean {
  if (role === 'ADMIN') return true;
  return ROLE_PERMISSIONS[role]?.includes(permission) ?? false;
}
