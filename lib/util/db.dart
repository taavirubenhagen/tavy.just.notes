import 'dart:convert';

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:just_notes/just/just.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class DBKeys {
  static const rootGroupId = "0";
  static const dataKey = "notes";
}


abstract class DataKeys {
  static const parent = "parent";
  static const isGroup = "group";
  static const title = "title";
  static const body = "body";
  static const isLocked = "locked";
  static const isPinned = "pinned";
  static const reminderMilliseconds = "reminder";
}


abstract class DB {
  
  static Future<bool> applyThemePreference() async => JustColors.lightMode = !( ( await SharedPreferences.getInstance() ).getBool("dark") ?? false );
  static Future<void> toggleThemePreference(void Function(void Function())? setParentState) async {
    JustColors.lightMode = !JustColors.lightMode;
    if (setParentState != null) {
      setParentState(() {});
    }
    ( await SharedPreferences.getInstance() ).setBool("dark", !JustColors.lightMode);
  }
  
  
  static Future<String> get completeJson async => ( await SharedPreferences.getInstance() ).getString(DBKeys.dataKey) ?? "No Data Found.";
  
  
  static Future<void> clean() async {
    final items = await all;
    if (items == null) return;
    for (final id in items.keys) {
      if (
        id != DBKeys.rootGroupId &&
        items[id]![DataKeys.parent] != null &&
        items[id]![DataKeys.parent] != DBKeys.rootGroupId &&
        !items.keys.contains(items[id]![DataKeys.parent])
      ) {
        await delete(id);
      }
    }
  }
  
  
  static Future<Map<String, Map<String, dynamic>>?> get all async {
    final instance = await SharedPreferences.getInstance();
    String? rawData = instance.getString(DBKeys.dataKey);
    if (rawData.runtimeType != String) {
      await instance.setString(DBKeys.dataKey, json.encode({
        DBKeys.rootGroupId: {
          "group": true,
        }
      }));
      rawData = instance.getString(DBKeys.dataKey);
      if (rawData == null) return null;
    }
    return Map<String, Map<String, dynamic>>.from(json.decode(rawData!));
  }
  
  
  static Future<String?> write({
    String? parentId,
    required String? id,
    bool? group,
    required Map<String, dynamic>? data,
    String? title,
    String? body,
    List<String>? items,
    bool? locked,
    bool? pinned,
    int? reminder,
  }) async {
    
    parentId ??= data?[DataKeys.parent] ?? DateTime.now().toIso8601String();
    id ??= DateTime.now().toIso8601String();
    group ??= data?[DataKeys.isGroup] ?? false;
    title ??= data?[DataKeys.title] ?? "";
    body ??= data?["body"] ?? "";
    locked = locked ?? data?[DataKeys.isLocked] ?? false;
    pinned = pinned ?? data?[DataKeys.isPinned] ?? false;
    // Caution: can be null
    reminder ??= data?[DataKeys.reminderMilliseconds];
    
    final instance = await SharedPreferences.getInstance();
    
    final currentData = await all;
    debugPrint(currentData.toString());
    if (currentData == null) return null;
    final newData = {
      DataKeys.parent: parentId,
      DataKeys.isGroup: group,
      DataKeys.title: title,
      DataKeys.body: body,
      DataKeys.isLocked: locked,
      DataKeys.isPinned: pinned,
      DataKeys.reminderMilliseconds: reminder,
    };
    currentData[id] = newData;
    
    await instance.setString(DBKeys.dataKey, json.encode(currentData));
    return id;
  }
  
  
  static Future<void> delete(String? id) async {
    final currentData = await all;
    if (currentData == null || id == null) return;
    currentData.remove(id);
    currentData.removeWhere((_, v) => ( v[DataKeys.parent] == id ));
    await ( await SharedPreferences.getInstance() ).setString(DBKeys.dataKey, json.encode(currentData));
    return;
  }
}