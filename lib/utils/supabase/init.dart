import 'package:supabase_flutter/supabase_flutter.dart';

const String _cloudEndpoint = 'https://yicrqldzzhsulmvwkzal.supabase.co';
const String _cloudAnon =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlpY3JxbGR6emhzdWxtdndremFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE1NTI1NjIsImV4cCI6MjAyNzEyODU2Mn0.xxJwiYFkyIVdYwdnc-T_c51QY4EU9-1ciHvUw2lucmc';

class SupabaseInit {
  static const String _endpoint = _cloudEndpoint;
  static const String _anon = _cloudAnon;

  static Future<Supabase> create() async => Supabase.initialize(
        url: _endpoint,
        anonKey: _anon,
      );
}
