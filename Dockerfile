FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["value-sample-api/value-sample-api.csproj", "value-sample-api/"]
RUN dotnet restore "value-sample-api/value-sample-api.csproj"
COPY . .
WORKDIR "/src/value-sample-api"
RUN dotnet build "value-sample-api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "value-sample-api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "value-sample-api.dll"]