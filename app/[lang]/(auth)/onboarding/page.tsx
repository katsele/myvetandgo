'use client';

import { useActionState } from 'react';
import { completeOnboarding } from './actions';

export default function OnboardingPage() {
  const [state, action, pending] = useActionState(completeOnboarding, null);

  return (
    <main className="flex flex-col items-center gap-6">
      <h1 className="text-2xl font-bold">Complétez votre profil</h1>
      <form action={action} className="flex w-full flex-col gap-4">
        <div>
          <label htmlFor="firstName" className="block text-sm font-medium">
            Prénom
          </label>
          <input
            id="firstName"
            name="firstName"
            required
            className="mt-1 w-full rounded border px-3 py-2"
          />
        </div>
        <div>
          <label htmlFor="lastName" className="block text-sm font-medium">
            Nom
          </label>
          <input
            id="lastName"
            name="lastName"
            required
            className="mt-1 w-full rounded border px-3 py-2"
          />
        </div>
        <div>
          <label htmlFor="language" className="block text-sm font-medium">
            Langue préférée
          </label>
          <select
            id="language"
            name="language"
            className="mt-1 w-full rounded border px-3 py-2"
          >
            <option value="FR">Français</option>
            <option value="NL">Nederlands</option>
          </select>
        </div>
        <div>
          <label htmlFor="country" className="block text-sm font-medium">
            Pays
          </label>
          <select
            id="country"
            name="country"
            className="mt-1 w-full rounded border px-3 py-2"
          >
            <option value="BE">Belgique</option>
            <option value="FR">France</option>
            <option value="LU">Luxembourg</option>
            <option value="NL">Pays-Bas</option>
            <option value="CH">Suisse</option>
          </select>
        </div>
        {state?.error && <p className="text-sm text-red-600">{state.error}</p>}
        <button
          type="submit"
          disabled={pending}
          className="rounded bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 disabled:opacity-50"
        >
          {pending ? 'Enregistrement...' : 'Commencer'}
        </button>
      </form>
    </main>
  );
}
