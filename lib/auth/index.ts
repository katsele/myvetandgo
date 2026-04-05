// Auth module — re-exports for convenience
export { authServer, getAppSession } from './server';
export { hasPermission, type Permission } from './permissions';
export { requireAuth, requireRole, requirePermission } from './guards';
