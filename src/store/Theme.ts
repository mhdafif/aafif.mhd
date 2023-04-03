import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";

interface ThemeState {
  theme: string;
}

const useThemeStore = create<ThemeState>()(
  // to track data on redux dev tools
  devtools(
    // to persist data
    persist(
      (set) => ({
        theme: "",
      }),
      {
        // persist only keep the data
        name: "theme-storage",
        // by default using localstorage
        // getStorage: () => sessionStorage,
      }
    )
  )
);

export default useThemeStore;
