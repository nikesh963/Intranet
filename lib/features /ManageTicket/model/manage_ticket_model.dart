
import 'package:flutter/material.dart';

class ManageTicketModel {
  final String id;
  final String employee;
  final String date;
  final String ticketCode;
  final String status; // 'Open', 'In Progress', 'Resolved', 'Closed'
  final String title;
  final String description;
  final String ro;
  final String newStatus;
  final String department;
  final String priority; // 'High', 'Medium', 'Low', 'Critical'
  final String createdBy;
  final String createdAt;
  final String? updatedAt;
  final String? resolvedAt;

  ManageTicketModel({
    required this.id,
    required this.employee,
    required this.date,
    required this.ticketCode,
    required this.status,
    required this.title,
    required this.description,
    required this.ro,
    required this.newStatus,
    required this.department,
    required this.priority,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
    this.resolvedAt,
  });

  // Helper method to get status color
  Color getStatusColor() {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approve':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  // Helper method to get priority color
  Color getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.yellow;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
        
    }
  }
}