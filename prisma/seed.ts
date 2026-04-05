import { PrismaNeon } from '@prisma/adapter-neon';
import { PrismaClient } from '../lib/generated/prisma/client';

const adapter = new PrismaNeon({
  connectionString: process.env.DATABASE_URL!,
});
const prisma = new PrismaClient({ adapter });

async function main() {
  // 1. Seed specialty: Urgences/ECC
  const specialty = await prisma.specialty.upsert({
    where: { slug: 'urgences-ecc' },
    update: {},
    create: {
      slug: 'urgences-ecc',
      nameFr: 'Urgences / ECC',
      nameNl: 'Spoedgevallen / ECC',
      descriptionFr:
        'Formation continue en médecine vétérinaire d\u2019urgence et soins intensifs',
      descriptionNl:
        'Bijscholing in veterinaire spoedgeneeskunde en intensieve zorgen',
      wave: 1,
      isActive: true,
      sortOrder: 1,
    },
  });

  console.log(`Specialty seeded: ${specialty.nameFr} (${specialty.slug})`);

  // 2. Seed organization: Vet&Go (internal)
  const org = await prisma.organization.upsert({
    where: { slug: 'vetandgo' },
    update: {},
    create: {
      name: 'Vet&Go',
      type: 'INTERNAL',
      slug: 'vetandgo',
      country: 'BE',
    },
  });

  console.log(`Organization seeded: ${org.name} (${org.slug})`);

  // 3. Seed admin user
  const admin = await prisma.user.upsert({
    where: { email: 'admin@myvetandgo.com' },
    update: {},
    create: {
      email: 'admin@myvetandgo.com',
      firstName: 'Admin',
      lastName: 'Vet&Go',
      language: 'FR',
      role: 'ADMIN',
      country: 'BE',
      organizationId: org.id,
    },
  });

  console.log(`Admin user seeded: ${admin.email}`);

  // 4. Seed CE accreditation rules
  const ceRules = [
    {
      country: 'BE' as const,
      bodyName: 'CRFOMV',
      pointsPerHour: 1,
      maxElearningPct: 60,
      validFrom: new Date('2025-01-01'),
    },
    {
      country: 'BE' as const,
      bodyName: 'NGROD',
      pointsPerHour: 1,
      maxElearningPct: 60,
      validFrom: new Date('2025-01-01'),
    },
    {
      country: 'FR' as const,
      bodyName: 'CFCV',
      pointsPerHour: 0.05, // 1 CFC per 20 hours
      maxElearningPct: 50,
      validFrom: new Date('2025-01-01'),
    },
    {
      country: 'LU' as const,
      bodyName: 'Collège Vétérinaire',
      pointsPerHour: 1,
      maxElearningPct: 100,
      validFrom: new Date('2025-01-01'),
    },
    {
      country: 'NL' as const,
      bodyName: 'CKRD',
      pointsPerHour: 1,
      maxElearningPct: 100,
      validFrom: new Date('2025-01-01'),
    },
    {
      country: 'CH' as const,
      bodyName: 'SVS',
      pointsPerHour: 1,
      maxElearningPct: 100,
      validFrom: new Date('2025-01-01'),
    },
  ];

  for (const rule of ceRules) {
    await prisma.ceAccreditation.upsert({
      where: {
        country_bodyName: {
          country: rule.country,
          bodyName: rule.bodyName,
        },
      },
      update: {},
      create: rule,
    });
  }

  console.log(`CE accreditation rules seeded: ${ceRules.length} records`);
}

main()
  .then(() => prisma.$disconnect())
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
