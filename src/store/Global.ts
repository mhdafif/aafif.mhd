import { create } from "zustand";
import { devtools } from "zustand/middleware";

interface IPopup {
  isOpen: boolean;
  message: string;
}
interface INotif {
  isOpen: boolean;
  title: any;
  message: string;
  type?: string;
}
interface IGlobal {
  loading: boolean;
  popup: IPopup;
  notif: INotif;

  // setLoading(type: string, value: boolean): void;
  setLoading(value: boolean): void;
}

const useGlobalStore = create<IGlobal>()(
  devtools((set) => ({
    loading: false,
    popup: {
      isOpen: false,
      message: "",
    },
    notif: {
      isOpen: false,
      title: "",
      type: "",
      message: "",
    },
    setLoading: (value: boolean) => set({ loading: value }),
  }))
);

export default useGlobalStore;
