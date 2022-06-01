FROM mcr.microsoft.com/dotnet/framework/sdk:5.0 AS build
WORKDIR /app

COPY SampleWebApplication .
RUN powershell nuget restore; msbuild /p:Configuration=Release /p:publishUrl=/out /p:DeployDefaultTarget=WebPublish /p:DeployOnBuild=True /p:WebPublishMethod=FileSystem /p:DeleteExistingFiles=True

FROM mcr.microsoft.com/dotnet/framework/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /out /inetpub/wwwroot
