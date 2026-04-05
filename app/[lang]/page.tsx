type Params = { lang: string };

export default async function LangHome({
  params,
}: {
  params: Promise<Params>;
}) {
  const { lang } = await params;

  return (
    <main className="flex flex-1 items-center justify-center">
      <h1 className="text-2xl font-semibold tracking-tight">
        {lang === 'nl' ? 'Welkom bij My Vet&Go' : 'Bienvenue sur My Vet&Go'}
      </h1>
    </main>
  );
}
