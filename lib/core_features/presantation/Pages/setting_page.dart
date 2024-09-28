import 'package:CIS_UnixCloud/core_features/Provider/cache_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CacheProvider>(context, listen: false).getFileSize();
    Provider.of<CacheProvider>(context, listen: false).updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CacheProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // cache toggle btn
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cache pdf",
                      style: TextStyle(
                        fontFamily: "dmsans",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    CupertinoSwitch(
                      value: value.isEnabled,
                      onChanged: (isEnabled) {
                        value.updatePref(isEnabled);
                        value.updateStatus();
                        // setState(() {
                        //   cacheStatus = value;
                        // });
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // clear cache
              ElevatedButton(
                onPressed: () async {
                  value.deleteCache();
                  value.getFileSize();
                },
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Clear Cache",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "dmsans",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${(value.sizeInByte / (1024 * 1024)).toStringAsFixed(2)}MB",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "dmsans",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
