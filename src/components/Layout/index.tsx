import React from "react";
import { Outlet } from "react-router-dom";

const Layout = () => {
  return (
    <>
      <p className="text-lg">Layout</p>
      <Outlet />
    </>
  );
};

export default Layout;
