export const isTrue = true;
export const isFalse = false;

// const width = screen.width;
// export const isLaptop = width > EScreenWidth.Laptop;
export const isLaptop = window.matchMedia("(min-width: 1024px)").matches;
