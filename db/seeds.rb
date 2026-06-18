# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   LHR London Heathrow
# LAX Los Angeles International
# JFK John F. Kennedy International
# CDG Paris Charles de Gaulle
# DXB Dubai International
# SIN Singapore Changi
# ORD Chicago O'Hare
# HND Tokyo Haneda
# AMS Amsterdam Schiphol
# YYZ Toronto Pearson

nyc = Airport.find_or_create_by!(code: 'NYC') # New York City
lax = Airport.find_or_create_by!(code: 'LAX') # Los Angeles International
jfk = Airport.find_or_create_by!(code: 'JFK') # John F. Kennedy International
cdg = Airport.find_or_create_by!(code: 'CDG') # Paris Charles de Gaulle
dxb = Airport.find_or_create_by!(code: 'DXB') # Dubai International
sin = Airport.find_or_create_by!(code: 'SIN') # Singapore Changi
ord = Airport.find_or_create_by!(code: 'ORD') # Chicago O'Hare
hnd = Airport.find_or_create_by!(code: 'HND') # Tokyo Haneda
ams = Airport.find_or_create_by!(code: 'AMS') # Amsterdam Schiphol
yyz = Airport.find_or_create_by!(code: 'YYZ') # Toronto Pearson

Flight.create!([
  { start: "2026-07-29 14:30:00", duration_mins: 180, departure_airport: nyc, arrival_airport: lax },
  { start: "2026-08-05 09:15:00", duration_mins: 420, departure_airport: jfk, arrival_airport: cdg },
  { start: "2026-09-12 22:45:00", duration_mins: 900, departure_airport: lax, arrival_airport: hnd },
  { start: "2026-10-04 07:00:00", duration_mins: 130, departure_airport: ord, arrival_airport: yyz },
  { start: "2026-11-18 18:20:00", duration_mins: 415, departure_airport: ams, arrival_airport: dxb },
  { start: "2026-12-23 05:50:00", duration_mins: 675, departure_airport: dxb, arrival_airport: sin },
  { start: "2027-01-08 11:40:00", duration_mins: 500, departure_airport: cdg, arrival_airport: ord },
  { start: "2027-02-14 16:10:00", duration_mins: 360, departure_airport: sin, arrival_airport: jfk }
])
