## To Run

- yarn / yarn install
- yarn dev

## Before commit DO THIS!

- yarn validate
  to check if there's an error or no, if exist please fix it first!

## To Build

- yarn build

## TAG - RELEASE

- npm version [major | minor | patch]
  (automatically create a tag with version as a name/label)
  [npm version](https://docs.npmjs.com/cli/v6/commands/npm-version)

- git tag
  (to check if the tag version in the list)
- git push origin --tags
  (to push all available tags)
- git push origin : <tag_name>
  (to push a single tag)

- git tag -d <tag_name>
  git push origin :refs/tags/<tag_name>
  (to remove a tag from local & repo)

- git tag <tag_name>
  create a tag
  [tags documentation](https://support.atlassian.com/bitbucket-cloud/docs/repository-tags/)

## ################################### Rule

- (View: such as login.tsx) - only have props, store & return of html/component
- (Logic: such as useLogin.tsx) - can have props, store, form, usestate, handler, useeffect, others, & return of each (no component in logic return)

## ################################### Documentation

## React

[twice-call-useeffect-didmount-only-dev](https://www.techiediaries.com/react-18-useeffect/)

## Vite

[vite env](https://vitejs.dev/guide/env-and-mode.html)

## React Router

[basic](https://github.com/remix-run/react-router/blob/dev/examples/basic/src/App.tsx)
[auth](https://github.com/remix-run/react-router/blob/dev/examples/auth/src/App.tsx)
[route](https://reactrouter.com/en/main/route/route)

## Zustand

[git-repo](https://github.com/pmndrs/zustand)

## Axios interceptor

[interceptor](https://www.bezkoder.com/axios-interceptors-refresh-token/)
[multiple-request](https://stackoverflow.com/questions/57890667/axios-interceptor-refresh-token-for-multiple-requests)

## Tailwind

[docs](https://tailwindcss.com/docs/configuration)

## ################################### Note

- Unused file can rename to js
- if confuse about type can be place with `any` first (later to correct one)
- try to build in local first before push to staging
