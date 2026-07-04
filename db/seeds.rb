# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# LHR London Heathrow
# LAX Los Angeles International
# JFK John F. Kennedy International
# CDG Paris Charles de Gaulle
# DXB Dubai International
# SIN Singapore Changi
# ORD Chicago O'Hare
# HND Tokyo Haneda
# AMS Amsterdam Schiphol
# YYZ Toronto Pearson

# Old seed data
# nyc = Airport.find_or_create_by!(code: 'NYC') # New York City
# lax = Airport.find_or_create_by!(code: 'LAX') # Los Angeles International
# jfk = Airport.find_or_create_by!(code: 'JFK') # John F. Kennedy International
# cdg = Airport.find_or_create_by!(code: 'CDG') # Paris Charles de Gaulle
# dxb = Airport.find_or_create_by!(code: 'DXB') # Dubai International
# sin = Airport.find_or_create_by!(code: 'SIN') # Singapore Changi
# ord = Airport.find_or_create_by!(code: 'ORD') # Chicago O'Hare
# hnd = Airport.find_or_create_by!(code: 'HND') # Tokyo Haneda
# ams = Airport.find_or_create_by!(code: 'AMS') # Amsterdam Schiphol
# yyz = Airport.find_or_create_by!(code: 'YYZ') # Toronto Pearson

# Flight.create!([
#   { start: "2026-07-29 14:30:00", duration_mins: 180, departure_airport: nyc, arrival_airport: lax },
#   { start: "2026-08-05 09:15:00", duration_mins: 420, departure_airport: jfk, arrival_airport: cdg },
#   { start: "2026-09-12 22:45:00", duration_mins: 900, departure_airport: lax, arrival_airport: hnd },
#   { start: "2026-10-04 07:00:00", duration_mins: 130, departure_airport: ord, arrival_airport: yyz },
#   { start: "2026-11-18 18:20:00", duration_mins: 415, departure_airport: ams, arrival_airport: dxb },
#   { start: "2026-12-23 05:50:00", duration_mins: 675, departure_airport: dxb, arrival_airport: sin },
#   { start: "2027-01-08 11:40:00", duration_mins: 500, departure_airport: cdg, arrival_airport: ord },
#   { start: "2027-02-14 16:10:00", duration_mins: 360, departure_airport: sin, arrival_airport: jfk }
# ])

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Design goal: a search on (departure_airport, arrival_airport, date) should almost always return
# a few results. We do this by:
#   1. Using a SMALL set of airports (5) so every ordered pair gets covered.
#   2. Using a SMALL set of dates (3) so search dates are easy to hit.
#   3. Creating multiple flights (different times) for every airport-pair on every date.
#
# JFK New York John F. Kennedy International
# LAX Los Angeles International
# CDG Paris Charles de Gaulle
# DXB Dubai International
# HND Tokyo Haneda

jfk = Airport.find_or_create_by!(code: 'JFK')
lax = Airport.find_or_create_by!(code: 'LAX')
cdg = Airport.find_or_create_by!(code: 'CDG')
dxb = Airport.find_or_create_by!(code: 'DXB')
hnd = Airport.find_or_create_by!(code: 'HND')

airports = [ jfk, lax, cdg, dxb, hnd ]

# Approximate real-world flight durations (mins) between each pair, symmetric in both directions.
DURATIONS = {
  %w[JFK LAX] => 330,
  %w[JFK CDG] => 430,
  %w[JFK DXB] => 780,
  %w[JFK HND] => 780,
  %w[LAX CDG] => 600,
  %w[LAX DXB] => 870,
  %w[LAX HND] => 660,
  %w[CDG DXB] => 415,
  %w[CDG HND] => 720,
  %w[DXB HND] => 510
}.freeze

def duration_for(a, b)
  DURATIONS[[ a.code, b.code ].sort] || DURATIONS[[ b.code, a.code ].sort]
end

# A small, fixed set of dates so it's easy to search and always find something.
SEARCH_DATES = %w[2026-07-15 2026-08-15 2026-09-15].freeze

# Multiple departure times per day per route, so each (departure, arrival, date) search
# returns more than one flight.
DEPARTURE_TIMES = [ '07:30:00', '15:45:00' ].freeze

# Clear out old flights first so this script is idempotent (safe to re-run).
Flight.delete_all

flights_attrs = []

SEARCH_DATES.each do |date|
  airports.each do |departure_airport|
    airports.each do |arrival_airport|
      next if departure_airport == arrival_airport

      DEPARTURE_TIMES.each do |time|
        flights_attrs << {
          start: "#{date} #{time}",
          duration_mins: duration_for(departure_airport, arrival_airport),
          departure_airport: departure_airport,
          arrival_airport: arrival_airport
        }
      end
    end
  end
end

Flight.create!(flights_attrs)

puts "Seeded #{airports.size} airports and #{flights_attrs.size} flights " \
     "across #{SEARCH_DATES.size} dates and #{DEPARTURE_TIMES.size} daily departure times."
