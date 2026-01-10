/// <reference types="svelte" />
/// <reference types="vite/client" />

declare module "$lib/*" {
  const value: unknown;
  export default value;
}

