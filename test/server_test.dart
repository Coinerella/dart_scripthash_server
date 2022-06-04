import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/dart_scripthash_server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Root', () async {
    final response = await get(Uri.parse('$host/'));
    expect(response.statusCode, 200);
    expect(response.body, 'method not found');
  });

  test('Successful scripthash request', () async {
    final response = await get(Uri.parse(
        '$host/scripthash/peercoin/p92W3t7YkKfQEPDb7cG9jQ6iMh7cpKLvwK'));
    expect(response.statusCode, 200);
    expect(response.body,
        'f83cf3b3ccddc19323fccef53417926f3303070abf4c6492164d2b0f513ad4e6');
  });

  test('Unsuccesful scripthash request (wrong network)', () async {
    final response = await get(Uri.parse(
        '$host/scripthash/anonexistingcoin/p92W3t7YkKfQEPDb7cG9jQ6iMh7cpKLvwK'));
    expect(response.statusCode, 400);
    expect(response.body, 'Network anonexistingcoin not available');
  });

  test('Unsuccesful scripthash request (wrong address)', () async {
    final response = await get(Uri.parse(
        '$host/scripthash/peercoin/p92W3t7YkKfQEPDb7cG9jQ6iMh7cpKLvw'));
    expect(response.statusCode, 400);
    expect(response.body,
        'Address p92W3t7YkKfQEPDb7cG9jQ6iMh7cpKLvw not valid for peercoin');
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
