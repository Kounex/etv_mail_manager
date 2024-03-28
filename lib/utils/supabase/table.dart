enum SupabaseTable {
  mails;

  String get apiName => switch (this) {
        SupabaseTable.mails => 'mails',
      };

  String get text => switch (this) {
        SupabaseTable.mails => 'Mails',
      };
}
