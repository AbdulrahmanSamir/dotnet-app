FROM mcr.microsoft.com/dotnet/sdk:5.0.408-buster-slim-amd64 AS build
WORKDIR /app

COPY *.sln .
COPY aspnetmvcapp/*.csproj ./aspnetmvcapp/
RUN nuget restore

COPY aspnetmvcapp/. ./aspnetmvcapp/
WORKDIR /app/aspnetmvcapp
RUN msbuild /p:Configuration=Release

FROM mcr.microsoft.com/dotnet/aspnet:5.0.17-bullseye-slim-amd64 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnetmvcapp/. ./
