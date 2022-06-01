FROM mcr.microsoft.com/dotnet/sdk:5.0.408-buster-slim-amd64 AS build
#mcr.microsoft.com/dotnet/framework/sdk:5.0
WORKDIR /app

COPY SampleWebApplication .
RUN powershell nuget restore; msbuild /p:Configuration=Release /p:publishUrl=/out /p:DeployDefaultTarget=WebPublish /p:DeployOnBuild=True /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True

FROM mcr.microsoft.com/dotnet/aspnet:5.0.17-bullseye-slim-amd64 AS runtime
#mcr.microsoft.com/dotnet/framework/aspnet:5.0
WORKDIR /app
COPY --from=build /out /inetpub/wwwroot
