import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifi_scan/wifi_scan.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  String currentRoom = 'Chưa xác định';
  List<WiFiAccessPoint> wifiNetworks = [];
  bool isLoading = false; // Track the loading state

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final can = await WiFiScan.instance.canStartScan();
    if (can == CanStartScan.yes) {
      scanWifiNetworks();
    } else {
      print("Không thể quét Wi-Fi.");
    }
  }

  Future<void> scanWifiNetworks() async {
    setState(() {
      isLoading = true; // Show loading spinner when starting scan
    });

    // Start scanning Wi-Fi networks and listen for results
    await WiFiScan.instance.startScan();
    WiFiScan.instance.onScannedResultsAvailable.listen((networks) {
      setState(() {
        wifiNetworks = networks;
        isLoading = false; // Hide loading spinner after scan is completed
        // currentRoom = identifyRoom(networks); // Uncomment to identify room
      });
    });
  }

  String identifyRoom(List<WiFiAccessPoint> networks) {
    // Sample signal fingerprint map (you can adjust this as needed)
    Map<String, Map<String, int>> signalFingerprint = {
      'Phòng 1': {'BSSID1': -40, 'BSSID2': -50},
      'Phòng 2': {'BSSID1': -70, 'BSSID2': -60},
    };

    String detectedRoom = 'Không xác định';
    int minDifference = double.infinity.toInt();

    signalFingerprint.forEach((room, signals) {
      int difference = 0;
      for (var network in networks) {
        if (signals.containsKey(network.bssid)) {
          difference += (signals[network.bssid]! - network.level).abs();
        }
      }
      if (difference < minDifference) {
        minDifference = difference;
        detectedRoom = room;
      }
    });

    return detectedRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/icon/arrow-left.svg',
                        width: 10),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Điểm danh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            // Display loading spinner if the app is loading
            Container(
              padding: const EdgeInsets.all(12),
              child: const Text(
                'Cấu trúc dữ liệu và giải thuật ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: scanWifiNetworks,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                decoration: const BoxDecoration(
                  color: Color(0xffC82524),
                  borderRadius: BorderRadius.all(
                      Radius.circular(16)), // Góc dưới bên phải
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.clock_12_filled,
                      color: Color(0xffffffff),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Điểm danh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading // Show loading indicator in the list view
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: wifiNetworks.length,
                      itemBuilder: (context, index) {
                        final network = wifiNetworks[index];
                        return ListTile(
                          title: Text(network.ssid ?? 'Không tên'),
                          subtitle: Text(
                              'BSSID: ${network.bssid}, Level: ${network.level}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
