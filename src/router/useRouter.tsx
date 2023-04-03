import About from "@/pages/About";
import Home from "@/pages/Home";

// pages
export enum EPath {
  home = "/",
  about = "/about",
}

// interface
interface IRoutes {
  index?: boolean;
  path: string | EPath;
  element: JSX.Element;
}

const useRouter = () => {
  /*======================== Others ======================== */

  const routes: IRoutes[] = [
    {
      index: true,
      path: EPath.home,
      element: <Home />,
    },
    {
      path: EPath.about,
      element: <About />,
    },
  ];

  /*======================== Return ======================== */

  return {
    routes,
  };
};

export default useRouter;
