FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build

COPY dockernginxtut/*.csproj ./app/dockernginxtut/

WORKDIR /app/dockernginxtut
RUN dotnet restore

COPY dockernginxtut/. ./dockernginxtut/
RUN dotnet publish -o out /p:PublishWithAspNetCoreTargetManifest="false"

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 as runtime
ENV ASPNETCORE_URLS http://+5000
EXPOSE 5000
WORKDIR /app
COPY --from=build /app/dockernginxtut/out ./
ENTRYPOINT [ "dotnet", "dockernginxtut.dll" ]

