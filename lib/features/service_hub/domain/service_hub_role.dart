enum ServiceHubRole {
  client,
  master;

  bool get isClient => this == ServiceHubRole.client;
  bool get isMaster => this == ServiceHubRole.master;
}
