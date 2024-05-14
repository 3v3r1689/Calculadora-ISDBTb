import 'package:flutter/material.dart';


List<String> UhfChannels = List.generate(51 - 14 + 1, (index) => (index + 14).toString());



List<DropdownMenuItem<String>> uhfItems = UhfChannels.map((String channel) {
  return DropdownMenuItem<String>(
    value: channel,
    child: Text(channel),
  );
}).toList();

