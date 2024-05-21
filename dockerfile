FROM mcr.microsoft.com/dotnet/sdk:8.0.203-windowsservercore-ltsc2019 AS build-env
WORKDIR /app

# Set the user to ContainerAdministrator
COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0.3-windowsservercore-ltsc2019
WORKDIR /app

COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "asp-net-getting-started.dll"]

#CMD ["cmd", "/S", "/C", "echo", "Build successful"]
