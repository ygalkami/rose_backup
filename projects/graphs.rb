require 'SVG/Graph/Pie'

titles = ["Alaska", "Arizona", "Arkansas", "California", "Connecticut", "Delaware", "DC", "Florida", "Georgia", "Hawaii", "Illionis", "Indiana", "Iowa", "Louisiana", "Massachusetts", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Texas", "Vermont", "Virgina", "Wisconsion"]

data = [[35.6, 19.5, 11, 33.9],
				[78.6, 5.6, 1.6, 14.2],
				[73.2, 4.2, 3.9, 3, 1.3, 14.4],
				[66.5, 4.8, 3.7, 3.3, 21.7],
				[49.1, 6.8, 6, 5.6, 32.5],
				[57.2, 4.2, 4.1, 3.3, 2.7, 28.5],
				[54.6, 8.3, 3, 34.1],
				[73.2, 6.8, 2.4, 17.6],
				[58.3, 3.5, 3.5, 34.7],
				[19.6, 16.7, 15.8, 47.9],
				[58.8, 7.8, 3.1, 30.3],
				[55.7, 7.8, 4.3, 32.2],
				[52, 9.3, 5.1, 33.6],
				[38, 31.5, 6.1, 5.5, 2.3, 16.6],
				[43, 17.2, 5.3, 34.5],
				[49.6, 4, 3.7, 39],
				[77.4, 10.6, 2.2, 1.7, 8.1],
				[50, 5.9, 4.7, 39.4],
				[66.5, 3.5, 3, 27],
				[31.1, 28.4, 7.4, 4.8, 3.5, 24.8],
				[32.3, 7.9, 4.9, 54.9],
				[86.4, 2, 1.2, 10.4],
				[40.1, 14.8, 6.9, 6.2, 4.9, 27.1],
				[45, 5.3, 4.4, 45.3],
				[50.6, 9.8, 7.5, 32.1]]

lang = [["Aleut-Eskimo 35.6%", "Spanish 19.5%", "Tagalog 11%", "Other 33.9%"],
				["Spanish	78.6", "Navajo	5.6",	"German	1.6", "Other 14.2"],
				["Spanish	73.2", "Vietnamese 4.2",	"German	3.9",	"French	3",	"Laotian 1.3",	"Other 14.4"],
				["Spanish	66.5", "Tagalog	4.8", "Chinese 3.7", "Vietnamese 3.3", "Other 21.7"],
				["Spanish	49.1", "Italian	6.8", "French	6",	"Polish	5.6", "Other 32.5"],
				["Spanish	57.2", "German 4.2", "French 4.1", "Chinese	3.3", "Kru, Ibo, Yoruba	2.7", "Other 28.5"],
				["Spanish	54.6", "French 8.3", "Amharic	3", "Other 34.1"],
				["Spanish	73.2", "French Creole	6.8",	"French	2.4", "Other 17.6"],
				["Spanish	58.3", "French 3.5", "Korean 3.5", "Other 34.7"],
				["Tagalog	19.6", "Japanese 16.7", "Hocano	15.8", "Other 47.9"],
				["Spanish	58.8", "Polish 7.8", "Tagalog	3.1", "Other 30.3"],
				["Spanish	55.7", "German 7.8", "Pennsylvania Dutch	4.3", "Other 32.2"],
				["Spanish	52", "German 9.3", "Serbo-Croatian	5.1", "Other 33.6"],
				["French 38", "Spanish 31.5", "Vietnamese	6.1", "Cajun 5.5", "French-Creole	2.3", "Other 16.6"],
				["Spanish	34", "Portuguese 17.2",	"Chinese 5.3", "Other 34.5"],
				["Spanish	49.6", "Italian	4", "Portuguese	3.7", "Other 39"],
				["Spanish	77.4", "Navajo 10.6",	"Keres 2.2", "Zuni 1.7", "Other 8.1"],
				["Spanish	50", "Chinese	5.9",	"Russian 4.7", "Other 39.4"],
				["Spanish	66.5", "French 3.5", "German 3", "Other 27"],
				["German 31.1", "Spanish 28.4", "French	7.4", "Norwegian 4.8", "Dakota 3.5", "Other 24.8"],
				["Spanish	32.3", "German 7.9", "Arabic 4.9", "Other 54.9"],
				["Spanish	86.4", "Vietnamese 2", "Chinese	1.2", "Other 10.4"],
				["French 40.1", "Spanish 14.8", "German	6.9",	"Japanese	6.2", "Italian 4.9", "Other 27.1"],
				["Spanish	45", "Korean 5.3", "Vietnamese 4.4", "Other 45.3"],
				["Spanish	50.6", "German 9.8", "Hmong	7.5", "Other 32.1"]]

graphs = []

data.length.times do |i|
	temp = SVG::Graph::Pie.new({
		:height => 600,
		:width  => 600,
		:fields => lang[i],
		:show_data_labels => true,
		:show_key_data_labels => true,
		:show_percent => false,
		:show_shadow => false,
		:datapoint_font_size => 16,
		:expanded => true,
		:expand_gap => 10,
	})

	temp.add_data({ :data => data[i], :title => titles[i], })

	file = File.new(titles[i] + ".svg", "w")
	file.write temp.burn()
	#graphs << temp
end


#print "Content-type: image/svg+xml\r\n\r\n"
#print graphs[2].burn();
