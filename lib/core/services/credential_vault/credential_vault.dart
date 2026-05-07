abstract class CredentialVault {
  Future<void> init();

  Future<String?> get projectId;
  Future<String?> get clientEmail;
  Future<String?> get privateKey;
}
