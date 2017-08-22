require 'sinatra'
require 'sinatra/activerecord'
require './models/model'
require './models/webscraping'

get '/' do
    erb :index
end

post "/execute" do
    webscrape = Dutro.new
    webscrape.febennett
    webscrape.source4industries
    webscrape.globalindustrial
    webscrape.chefsfirst
    webscrape.oliveroutlet
    webscrape.glutco
    redirect "/"
end


post "/dead" do
    Model.destroy_all
    return "it all... has been destroyed"
end


get "/dutrofiltered" do

    dutroModelNumbers = [
        '16x30HD',
        '16x30LD',
        '18x30HD',
        '18x30LD',
        '24x36HD',
        '24x48HD',
        '24x36HD-3SHELF',
        '24x48HD-3SHELF',
        '1350',
        '1354',
        '1355',
        '1360',
        'SM18-53',
        'SM22-41',
        'SM18-75',
        'SM5B',
        'SM58B',
        'DWC2X4-FRM',
        'DWC2X4',
        '2040',
        '2041-PT',
        '3019',
        '3024',
        '3034W',
        '3023',
        'A48PMP',
        'A48PNP',
        'A48PSP',
        'A48RSP',
        'A48RMP',
        'A48RNP',
        'A58PMP',
        'A58PNP',
        'A58PSP',
        'A58RMP',
        'A58RNP',
        'A58RSP',
        'A58PMDL',
        'A58PNDL',
        'A58PSDL',
        'A510PSP',
        'A510PBP',
        'A510PNP',
        'A510PSDL',
        'A510PNDL',
        'A510PBDL',
        'A510RSDL',
        'A510RBDL',
        'A510RNDL',
        'RET50N',
        'RET50S',
        'RET51N',
        'RET51S',
        'RET52N',
        'RET52S',
        '5210S',
        '5210N',
        '5210B',
        '5110B',
        '5110N',
        '5110S',
        '137',
        '5010B',
        '5010N',
        '5010S',
        '510PNDL',
        '510PBDL',
        '510PSDL',
        '510PNP',
        '510PBP',
        '510PSP',
        '58PNL',
        '58PML',
        '58PSL',
        '58PMDL',
        '58PNDL',
        '58PSDL',
        '58PMP',
        '58PNP',
        '58PSP',
        '58PMP-DLX',
        '58PMP-HD',
        '48PMP',
        '48PNP',
        '48PSP',
        '48PMP-HD',
        '122',
        '122-8N',
        '120',
        '120-8N',
        '120-8S',
        'AHT8S-A',
        '1404',
        '1404SO',
        '1420',
        '1420SO',
        '1504',
        '1509',
        '1900N',
        '1900P',
        '903',
        '904',
        '908M',
        '908N',
        '960',
        '950',
        '3000',
        '3002',
        '3004',
        'D-SBSO-M',
        'BEV-58B',
        'BEV-58S',
        '1866',
        '1872-BRUTE',
        '1872-SB',
        '1878',
        '1878-SB',
        '1888',
        '1888-78"TALL',
        '138',
        '808B',
        '808S',
        '810S',
        '810B',
        '828B',
        '828S',
        '820S',
        '820B',
        '100',
        '100-8S',
        '100-8P',
        '100-DLX-60',
        'R-DTT8S',
        'R-DTT10S',
        'R-DTT10N',
        'D-CYKO-10N',
        'D-CYKO-10S',
        'D-CYKO',
        'D-4WS-CYKO',
        'D-4WS-CYKO-10N',
        'D-4WS-CYKO-10S',
        'D-LCA126-N',
        'D-LCA126',
        'H5B',
        'H5B-SOLID',
        'LT5B',
        '24X36PT',
        '24X48PT',
        '6016-UBT',
        '6018-UBT',
        'LUM-8X2-6MRR',
        'LUM-8X2-8POR',
        'P-18C',
        'P-18L',
        'P-18D',
        'P-18F',
        'P-16E',
        'P-18Y',
        'P-16CD',
        'P-15D',
        'P-18H',
        'P-35D',
        'P-32D',
        'P-30D',
        'P-31D',
        'P-14D',
        'P-40D',
        'P-40D-1',
        'P-15A',
        'P-15B',
        'P-15C',
        'P-15D',
        'P-15E',
        'P-15F',
        'P-16A',
        'P-16C',
        'P-16E',
        'P-18A',
        'P-18B',
        'P-18C',
        'P-18D',
        'P-18F',
        'P-18G',
        'P-18H',
        'P-18L',
        'P-18S',
        'P-18TH',
        'P-18Y',
        'P-21A',
        'P-23',
        'P-30',
        'P-3000-4',
        '1-3000-07L',
        '1-3000-07R',
        'P-31',
        'P-32',
        'P-35',
        'P-38',
        'P-70',
        'P-71',
        'P-AXLE-SLEEVE',
        'P-BB1',
        'P-BB34',
        'P-BB58',
        'P-BS120',
        'P-BUMP-BLK',
        'P-BUMPER',
        'P-FN',
        '1-KH',
        'P-SPRING-100',
        'P-SPRING-120',
        'P-SPRING-1800',
        'P-SW120',
        'P-SW120-W0',
        'P-WASH-1',
        'P-WASH-34',
        'P-WASH-58',
        'P-WG',
        'W-M10',
        'W-M52',
        'W-M62-58',
        'W-M62-34',
        'W-M8258-58',
        'M-M8234-34',
        'W-N10',
        'W-N12',
        'W-N8',
        'W-S10275-58',
        'W-S10275-34',
        'W-S8-52-5-58',
        'S-S8-52-5-34',
        'S-S82-5-58',
        'S-S82-5-34',
        'W-SP8',
        'W-SP10',
        'W-SP12',
        'W-C4R',
        'W-C4S',
        'W-C4SP',
        'W-C5R',
        'W-C5S',
        'W-C5SP',
        'DTS-3060-6MRR',
        'DTS-3060-8MRR',
        'DTS-3060-6PHR',
        'DTS-3060-8PHR',
        'DTS-3060-6POR',
        'DTS-3060-8POR',
        'DTS-3060-8PN',
        'DTS-3060-10PN',
        'DTS-3060-12PN',
        'DTS-3672-6MRR',
        'DTS-3672-8MRR',
        'DTS-3672-6PHR',
        'DTS-3672-8PHR',
        'DTS-3672-6POR',
        'DTS-3672-8POR',
        'DTS-3672-10PN',
        'DTS-3672-12PN',
        '58RMP',
        '58RNP',
        '58RSP',
        '58RMDL',
        '58RNDL',
        '58RSDL',
        '48RMP',
        '48RBP',
        '48RNP',
        '48RSP',
        '510RNP',
        '510RSP',
        '58RMP-HD',
        'R-UPC220',
        'P-73',
        'P-10',
        'P-11',
        'BEV-64B',
        'BEV-64S',
        'BEV58B-CL',
        'BEV58S-CL',
        'D-LC126-N',
        '1291',
        '1292',
        '1293',
        'CR24x26-SURPLUS',
        '2041-PT-W/O',
        '2040-W/O'
    ]

    allModels = Model.all

    @models = []

    allModels.each do |model|
        if dutroModelNumbers.include? model.modelnumber
            @models.push(allModels.where(modelnumber: model.modelnumber).order(:price).first)
        end
    end


    erb :models
end

get "/dutro" do
    @models = Model.where(name: "dutro")
    erb :models
end

get "/model/new" do
    erb :new
end

post "/new" do
    @model = Model.new(params[:model])

    if @model.save
        redirect '/all'
    else
        "Sorry, there was an error!"
    end
end

get "/model/:id" do
    @model = Model.find(params[:id])

    erb :edit
end

post "/model/:id" do
    @model = Model.find(params[:id])

    erb :edit
end

put "/model/:id" do
    @model = Model.find(params[:id])
    @model.update(params[:model])
    redirect to("/model/#{params[:id]}")
end

get "/all" do
    @models = Model.all
    erb :models
end
