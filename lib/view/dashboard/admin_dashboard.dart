import 'package:admincoffee/view/dashboard/add_product.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
        title: const Text(
          "☕ CoffeeShop Admin",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // TODO: Logout logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text(
              "Welcome, Admin 👋",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 20),

            // Stats Section
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard("Total Products", "120", Icons.local_cafe),
                _buildStatCard("Total Orders", "540", Icons.shopping_cart),
                _buildStatCard("Pending Orders", "32", Icons.pending_actions),
                _buildStatCard("Daily Sales", "\$450", Icons.attach_money),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Actions
            const Text(
              "Quick Actions",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14)),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Add Product",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const AddProductPage()));
                  },
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14)),
                  icon: const Icon(Icons.receipt_long, color: Colors.white),
                  label: const Text("View Orders",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    // TODO: View orders logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recent Orders
            const Text(
              "Recent Orders",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 12),
            _buildOrderTile("Order #1012", "Latte x2", "Completed"),
            _buildOrderTile("Order #1013", "Cappuccino", "Pending"),
            _buildOrderTile("Order #1014", "Iced Mocha", "In Progress"),
            _buildOrderTile("Order #1015", "Espresso", "Completed"),
            const SizedBox(height: 20),

            // Monthly Performance Graph
            const Text(
              "📈 Monthly Performance",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 200, child: _MonthlySalesChart()),
            const SizedBox(height: 20),

            // Revenue Overview
            const Text(
              "Revenue Overview",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 12),
            _buildRevenueCard("Total Revenue", "\$12,450", Colors.green),
            _buildRevenueCard("Pending Payments", "\$650", Colors.orange),
          ],
        ),
      ),
    );
  }

  // Reusable stat card
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: Colors.brown),
            const SizedBox(height: 12),
            Text(value,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Reusable order tile
  Widget _buildOrderTile(String orderId, String details, String status) {
    Color statusColor;
    switch (status) {
      case "Completed":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.receipt, color: Colors.brown),
        title: Text(orderId),
        subtitle: Text(details),
        trailing: Text(status,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: statusColor, fontSize: 14)),
      ),
    );
  }

  // Reusable revenue card
  Widget _buildRevenueCard(String title, String amount, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: color, size: 30),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        trailing: Text(amount,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }
}

// Monthly Sales Chart using fl_chart
class _MonthlySalesChart extends StatelessWidget {
  const _MonthlySalesChart();

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 35),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
              if (value.toInt() >= 0 && value.toInt() < months.length) {
                return Text(months[value.toInt()]);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          color: Colors.brown,
          barWidth: 4,
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 3),
            FlSpot(2, 5),
            FlSpot(3, 4),
            FlSpot(4, 6),
            FlSpot(5, 7),
          ],
        ),
      ],
    ));
  }
}
