drop table if exists tmp_load_innovata;

create table tmp_load_innovata
(
	carrier	char(6) not null,
	flight_number	varchar(6) not null,
	ssim_codeshare_flag	char(1),
	ssim_codeshare_carrier	varchar(3),
	service_type	char(1),
	effective_start	char(10) not null,
	effective_end	char(10) not null,
	monday_flag		numeric(1, 0) not null,
	tuesday_flag	numeric(1, 0) not null,
	wednesday_flag	numeric(1, 0) not null,
	thursday_flag	numeric(1, 0) not null,
	friday_flag		numeric(1, 0) not null,
	saturday_flag	numeric(1, 0) not null,
	sunday_flag		numeric(1, 0) not null,
	origin			char(3) not null,
	origin_country	char(2) not null,
	origin_region	char(2),
	origin_city		char(3) not null,
	published_departure_time	char(8) not null,
	slotted_departure_time	char(8) not null,
	departure_utc_offset	numeric(4, 2) not null,
	departure_terminal	varchar(2),
	destination		char(3) not null,
	published_arrival_time	char(8) not null,
	slotted_arrival_time	char(8) not null,
	arrival_utc_offset	numeric(4, 2) not null,
	arrival_terminal	varchar(2),
	aircraft_code	char(3) not null,
	aircraft_class	char(3) not null,
	destination_country	char(2) not null,
	destination_region	char(2),
	destination_city	char(3) not null,
	booking_classes	varchar(4),
	booking_classes_full	varchar(40),
	traffic_restriction	char(1),
	arrival_day_offset	numeric(1, 0) not null,
	number_stops	numeric(2, 0) not null,
	stop_codes	varchar(80),
	stop_restrictions	varchar(27),
	aircraft_change_flag	numeric(1, 0),
	aircraft_code_list	varchar(84) not null,
	meal_codes	varchar(200),
	flight_distance	numeric(5, 0) not null,
	flight_duration	numeric(4, 0) not null,
	layover_duration	numeric(4, 0) not null,
	itinerary_variation	numeric(4, 0) not null,
	leg_number	numeric(4, 0) not null,
	in_flight_service	varchar(50),
	codeshare_flag	numeric(1, 0) not null,
	wetlease_flag	numeric(1, 0) not null,
	codeshare_info	varchar(155),
	wetlease_info	varchar(155),
	record_id	numeric(10, 0) not null primary key
)
ENGINE = MyISAM;



LOAD DATA INFILE '/export/mysql/import/paxdata/Sectorised_Global_Sample_Dec_31.csv'
INTO TABLE tmp_load_innovata
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(carrier,
flight_number,
ssim_codeshare_flag,
ssim_codeshare_carrier,
service_type,
effective_start,
effective_end,
monday_flag,
tuesday_flag,
wednesday_flag,
thursday_flag,
friday_flag,
saturday_flag,
sunday_flag,
origin,
origin_country,
origin_region,
origin_city,
published_departure_time,
slotted_departure_time,
departure_utc_offset,
departure_terminal,
destination,
published_arrival_time,
slotted_arrival_time,
arrival_utc_offset,
arrival_terminal,
aircraft_code,
aircraft_class,
destination_country,
destination_region,
destination_city,
booking_classes,
booking_classes_full,
traffic_restriction,
arrival_day_offset,
number_stops,
stop_codes,
stop_restrictions,
aircraft_change_flag,
aircraft_code_list,
meal_codes,
flight_distance,
flight_duration,
layover_duration,
itinerary_variation,
leg_number,
in_flight_service,
codeshare_flag,
wetlease_flag,
codeshare_info,
wetlease_info,
record_id);

insert into innovata
(carrier, flight_number, ssim_codeshare_flag, ssim_codeshare_carrier, service_type, effective_start, effective_end, monday_flag, tuesday_flag, wednesday_flag, thursday_flag, friday_flag, saturday_flag,
sunday_flag, origin, origin_country, origin_region, origin_city, published_departure_time, slotted_departure_time, departure_utc_offset, departure_terminal, destination, published_arrival_time, slotted_arrival_time,
arrival_utc_offset, arrival_terminal, aircraft_code, aircraft_class, destination_country, destination_region, destination_city, booking_classes, booking_classes_full, traffic_restriction, arrival_day_offset,
number_stops, stop_codes, stop_restrictions, aircraft_change_flag, aircraft_code_list, meal_codes, flight_distance, flight_duration, layover_duration, itinerary_variation, leg_number, in_flight_service,
codeshare_flag, wetlease_flag, codeshare_info, wetlease_info, record_id)
select carrier, flight_number, ssim_codeshare_flag, ssim_codeshare_carrier, service_type, 
STR_TO_DATE(effective_start,'%d/%m/%Y') as effective_start,
STR_TO_DATE(effective_end,'%d/%m/%Y') as effective_end,
monday_flag, tuesday_flag, wednesday_flag, thursday_flag, friday_flag, saturday_flag,
sunday_flag, origin, origin_country, origin_region, origin_city, 
STR_TO_DATE(published_departure_time, '%H:%i:%S') as published_departure_time, 
STR_TO_DATE(slotted_departure_time,'%H:%i:%S') as slotted_departure_time, 
departure_utc_offset, departure_terminal, destination, 
STR_TO_DATE(published_arrival_time, '%H:%i:%S') as published_arrival_time, 
STR_TO_DATE(slotted_arrival_time, '%H:%i:%S') as slotted_arrival_time,
arrival_utc_offset, arrival_terminal, aircraft_code, aircraft_class, destination_country, destination_region, destination_city, booking_classes, booking_classes_full, traffic_restriction, arrival_day_offset,
number_stops, stop_codes, stop_restrictions, aircraft_change_flag, aircraft_code_list, meal_codes, flight_distance, flight_duration, layover_duration, itinerary_variation, leg_number, in_flight_service,
codeshare_flag, wetlease_flag, codeshare_info, wetlease_info, record_id
from tmp_load_innovata;

drop table if exists tmp_load_innovata;


create index idx_innovata_cod on innovata(carrier, origin, destination);