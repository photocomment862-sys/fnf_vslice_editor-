import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const FnfChartEditor());
  }

  class FnfChartEditor extends StatelessWidget {
    const FnfChartEditor({super.key});

      @override
        Widget build(BuildContext context) {
            return MaterialApp(
                  title: 'FNF V-Slice Chart Editor',
                        theme: ThemeData.dark(),
                              home: const ChartEditorPage(),
                                  );
                                    }
                                    }

                                    class ChartEditorPage extends StatefulWidget {
                                      const ChartEditorPage({super.key});

                                        @override
                                          State<ChartEditorPage> createState() => _ChartEditorPageState();
                                          }

                                          class _ChartEditorPageState extends State<ChartEditorPage> {
                                            List<Map<String, dynamic>> notes = [];

                                              void _addNote() {
                                                  setState(() {
                                                        notes.add({
                                                                "time": DateTime.now().millisecondsSinceEpoch % 100000, // örnek zaman
                                                                        "direction": ["left", "down", "up", "right"][notes.length % 4]
                                                                              });
                                                                                  });
                                                                                    }

                                                                                      Future<void> _saveChart() async {
                                                                                          final chartData = {
                                                                                                "song": "example",
                                                                                                      "notes": notes,
                                                                                                          };

                                                                                                              final directory = await getApplicationDocumentsDirectory();
                                                                                                                  final file = File('${directory.path}/chart.json');
                                                                                                                      await file.writeAsString(jsonEncode(chartData));

                                                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                                SnackBar(content: Text("Kaydedildi: ${file.path}")),
                                                                                                                                    );
                                                                                                                                      }

                                                                                                                                        @override
                                                                                                                                          Widget build(BuildContext context) {
                                                                                                                                              return Scaffold(
                                                                                                                                                    appBar: AppBar(
                                                                                                                                                            title: const Text("FNF V-Slice Chart Editor"),
                                                                                                                                                                  ),
                                                                                                                                                                        body: Column(
                                                                                                                                                                                children: [
                                                                                                                                                                                          ElevatedButton(
                                                                                                                                                                                                      onPressed: _addNote,
                                                                                                                                                                                                                  child: const Text("Nota Ekle"),
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                      Expanded(
                                                                                                                                                                                                                                                  child: ListView.builder(
                                                                                                                                                                                                                                                                itemCount: notes.length,
                                                                                                                                                                                                                                                                              itemBuilder: (context, index) {
                                                                                                                                                                                                                                                                                              final note = notes[index];
                                                                                                                                                                                                                                                                                                              return ListTile(
                                                                                                                                                                                                                                                                                                                                title: Text("Time: ${note['time']}"),
                                                                                                                                                                                                                                                                                                                                                  subtitle: Text("Direction: ${note['direction']}"),
                                                                                                                                                                                                                                                                                                                                                                  );
                                                                                                                                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                                                                                                                                ElevatedButton(
                                                                                                                                                                                                                                                                                                                                                                                                                            onPressed: _saveChart,
                                                                                                                                                                                                                                                                                                                                                                                                                                        child: const Text("JSON Olarak Kaydet"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                          ],
                                                                                                                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                    );
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      }