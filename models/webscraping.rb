require 'mechanize'
require 'sucker_punch'
require 'watir'

class Dutro
    include SuckerPunch::Job

    def perform(event)
    end

    def chefsfirst
        mechanize = Mechanize.new


        link = ["http://www.chefsfirst.com/Hand-Truck-W-Push-Off-p/dtr100ezoff.htm", "http://www.chefsfirst.com/Hand-Truck-p/dtr58pmp.htm"]

        link.each do |product|

            page = mechanize.get(product)
            itemNumber = page.at("#product_description h1").text.split(" ").last
            itemUrl = page.uri
            itemPrice = page.at(".colors_pricebox .product_productprice span").text
            itemImage = page.at("#product_photo_zoom_url img")['src']
            itemWebsite = "chefsfirst"
            itemName = "dutro"


            mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

            if mymodel.empty?
                p = Model.new
                p.name    = itemName
                p.url     = itemUrl
                p.price   = itemPrice.to_f
                p.image   = itemImage
                p.website = itemWebsite
                p.modelnumber = itemNumber
            else

                mymodel.first.price = itemPrice.to_f
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save
            end

        end

    end

    def febennett
        mechanize = Mechanize.new

        mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        urls = ["https://febennett.com/products?keywords=dutro&utf8=%E2%9C%93", "https://febennett.com/products?keywords=dutro&page=2&utf8=%E2%9C%93", "https://febennett.com/products?keywords=dutro&page=3&utf8=%E2%9C%93", "https://febennett.com/products?keywords=dutro&page=4&utf8=%E2%9C%93"]

        urls.each do |page|
            products = mechanize.get(page)
            elements = products.search("#products li a")
            elements.each do |item|
                sleep(2)
                singlepage = mechanize.click(item)

                table = singlepage.at(".table-container table tbody")

                table_data = table.search('tr').map do |row|
                    row.search('th, td').map { |cell| cell.text.strip }
                end

                table_data.each do |row|
                    itemModel = row[0]
                    itemPrice = row[-2].gsub(/[$]/, "").to_f
                    itemUrl = singlepage.uri
                    itemImage = singlepage.at("#product-images #main-image img")['src']
                    itemName = "dutro"
                    itemWebsite = "febennett"

                    mymodel = Model.where(modelnumber: itemModel, website: itemWebsite)

                    if mymodel.empty?
                        p = Model.new
                        p.name    = itemName
                        p.url     = itemUrl
                        p.price   = itemPrice
                        p.image   = itemImage
                        p.website = itemWebsite
                        p.modelnumber = itemModel
                        p.save

                    else

                        mymodel.first.price = itemPrice
                        mymodel.first.image = itemImage
                        mymodel.first.url = itemUrl
                        mymodel.first.website = itemWebsite
                        mymodel.first.save
                    end


                end
            end
        end

    end

    def globalindustrial
        mechanize = Mechanize.new

        dutro = mechanize.get("http://www.globalindustrial.com/shopByBrandName/D/dutro-co")

        listitems = dutro.search(".grid .prod li .item a.ga_eecom")

        listitems.each do |x|
            page = mechanize.click(x)
            sleep(1)

            itemProductkey = page.at("#details .info .title").text.strip
            itemPrice = page.at("#details .price span:nth-child(2)").text.strip
            itemImage = page.at("#details div.enlarge img")['src']
            itemUrl = page.uri
            itemName = "dutro"
            itemWebsite = "globalindustrial"


            itemProductkey = itemProductkey.split(" ")[1] #

            mymodel = Model.where(modelnumber: itemProductkey)

            if mymodel.empty?

                p = Model.new

                p.name          = itemName
                p.modelnumber   = itemProductkey
                p.price         = itemPrice.to_f
                p.image         = itemImage
                p.url           = itemUrl
                p.website       = itemWebsite

                p.save
                puts "made and saved"

            else


                mymodel.first.price = itemPrice.to_f
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save

                puts "did that stuff"

            end
        end
    end

    def glutco
        mechanize = Mechanize.new
        mechanize.verify_mode = OpenSSL::SSL::VERIFY_PEER

        cert_store = OpenSSL::X509::Store.new
        cert_store.add_file 'cacert.pem'
        mechanize.cert_store = cert_store

        mechanize.ssl_version = "TLSv1"

        urls = ["https://glutco.com/search?q=dutro", "https://glutco.com/search?page=2&q=dutro"]

        urls.each do |x|
            page = mechanize.get(x)
            items = page.search("#product-loop .product")

            items.each do |x|
                sleep(1)

                itemName = "dutro"
                itemWebsite = "glutco"
                itemPrice = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                itemImage = x.at("a img")['src']
                itemUrl = mechanize.click(x.at(".product-details a")).uri
                itemNumber = x.at(".product-details h3").text.split(" ")[1]


                mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

                if mymodel.empty?
                    p = Model.new
                    p.name    = itemName
                    p.url     = itemUrl
                    p.price   = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                    p.image   = itemImage
                    p.website = itemWebsite
                    p.modelnumber = x.at(".product-details h3").text.split(" ")[1]
                    p.save

                else

                    mymodel.first.price = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                    mymodel.first.image = itemImage
                    mymodel.first.url = itemUrl
                    mymodel.first.website = itemWebsite
                    mymodel.first.save
                end

            end
        end


    end

    def oliveroutlet
        mechanize = Mechanize.new

        page = mechanize.get("http://oliversoutlet.com/search.aspx?find=dutro&log=false&size=200")

        links = page.search(".product-list-options h5 a")

        links.each do |item|
            sleep(1)

            page = mechanize.click(item)
            itemName = "dutro"
            itemWebsite = "oliversoutlet"
            itemUrl = page.uri
            itemPrice = page.at(".prod-detail-cost-value").text
            image = page.at("td.page-column-center a img")['src']
            itemImage = "http://oliversoutlet.com" + image
            itemProductkey = item.text.split(",")[0].gsub(/[..]/, "")

            mymodel = Model.where(modelnumber: itemProductkey, website: itemWebsite)

            if mymodel.empty?
                p = Model.new
                p.name    = itemName
                p.url     = itemUrl
                p.price   = itemPrice.gsub(/[$]/, "").to_f
                p.image   = itemImage
                p.website = itemWebsite
                p.modelnumber = itemProductkey
            else

                mymodel.first.price = itemPrice.gsub(/[$]/, "").to_f
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save
            end
        end
    end

    def source4industries
        mechanize = Mechanize.new

        mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        page = mechanize.get("https://source4industries.com/index.php?route=product/manufacturer/info&manufacturer_id=13&limit=131")


        links = page.search(".product-grid .image a")


        links.each do |item|
            itempage = mechanize.click(item)

            sleep(1)

            itemName = "dutro"
            itemPrice = itempage.at("span.o-price").text.gsub(/[$]/, "")
            itemUrl = itempage.uri
            itemImage = itempage.at(".product-info .image-additional img")["src"]
            itemNumber = itempage.at(".product-info h1").text.split(" - ").last.gsub(/\s+/, '')

            mymodel = Model.where(modelnumber: itemNumber)

            if mymodel.empty?
                puts "empty"
                p = Model.new
                p.name = itemName
                p.price = itemPrice.to_f
                p.url = itemUrl
                p.image = itemImage
                p.modelnumber = itemNumber
                p.website = "source4industries"
                p.save

            else
                mymodel.first.price = itemPrice.to_f
                mymodel.first.website = "source4industries"
                mymodel.first.save
                puts "did that stuff"
            end

        end
    end
end

class Vestil
    include SuckerPunch::Job

    def perform(event)
    end

    def globalindustrial
        mechanize = Mechanize.new

        (1..14).each do |x|
            vestil = mechanize.get("http://www.globalindustrial.com/shopByBrandName/V/vestil-manufacturing?cp=#{x}")

            listitems = vestil.search(".grid .prod li .item a.ga_eecom")

            listitems.each do |x|

                page = mechanize.click(x)
                sleep(1)

                itemProductkey = page.at("#details .info .title").text.strip


                if page.at("#details .price span:nth-child(2)")
                    itemPrice = page.at("#details .price span:nth-child(2)").text.strip
                elsif page.at(".price_breaks tbody tr td:nth-child(2)")
                    itemPrice = page.at(".price_breaks tbody tr td:nth-child(2)").text.strip
                end

                itemImage = page.at("#details div.enlarge img")['src']
                itemUrl = page.uri
                itemName = "vestil"
                itemWebsite = "globalindustrial"

                tableElement = page.search(".prodSpec ul ul li span")

                tableElement.each do |element|
                    if element.text == "MANUFACTURERS PART NUMBER"
                        number = tableElement.index(element) + 1
                        itemProductkey = tableElement[number].text
                    end
                end

                mymodel = Model.where(modelnumber: itemProductkey, name: itemName)

                if mymodel.empty?

                    p = Model.new

                    p.name          = itemName
                    p.modelnumber   = itemProductkey
                    p.price         = itemPrice.to_f
                    p.image         = itemImage
                    p.url           = itemUrl
                    p.website       = itemWebsite

                    p.save
                    puts "made and saved"
                else


                    mymodel.first.price = itemPrice.to_f
                    mymodel.first.image = itemImage
                    mymodel.first.url = itemUrl
                    mymodel.first.website = itemWebsite
                    mymodel.first.save

                    puts "did that stuff"

                end
            end
        end
    end

    def glutco
        mechanize = Mechanize.new
        mechanize.verify_mode = OpenSSL::SSL::VERIFY_PEER

        cert_store = OpenSSL::X509::Store.new
        cert_store.add_file 'cacert.pem'
        mechanize.cert_store = cert_store

        mechanize.ssl_version = "TLSv1"


        (1..264).each do |x|
            page = mechanize.get("https://glutco.com/search?page=#{x}&q=dutro")
            items = page.search("#product-loop .product")

            items.each do |x|
                sleep(1)

                itemName = "dutro"
                itemWebsite = "glutco"
                itemPrice = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                itemImage = x.at("a img")['src']
                itemUrl = mechanize.click(x.at(".product-details a")).uri
                itemNumber = x.at(".product-details h3").text.split(" ")[1]


                mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

                if mymodel.empty?
                    p = Model.new
                    p.name    = itemName
                    p.url     = itemUrl
                    p.price   = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                    p.image   = itemImage
                    p.website = itemWebsite
                    p.modelnumber = x.at(".product-details h3").text.split(" ")[1]
                    p.save

                else

                    mymodel.first.price = x.at(".price .prod-price").text.gsub(/[$]/, "").to_f
                    mymodel.first.image = itemImage
                    mymodel.first.url = itemUrl
                    mymodel.first.website = itemWebsite
                    mymodel.first.save
                end

            end
        end


    end

    def hofequipment
        mechanize = Mechanize.new

        page = mechanize.get("http://hofequipment.com/cart.php?m=search_results&catID=&venID=&search=vestil&shopByPrice=&sortBy=&viewAll=1")

        mylinks = page.search(".item-info .item-name a")

        mylinks.each do |x|
            openpage = mechanize.click(x)
            sleep(3)

            table = openpage.at(".chartPersonalization tbody")

            if table

                table_data = table.search('tr').map do |row|
                    row.search('th, td').map { |cell| cell.text.strip }
                end

                table_data.each do |row|
                    itemNumber = row[0]
                    itemUrl    = openpage.uri
                    itemPrice  = row[-2].gsub(/[$]/, "").gsub(/[()]/, "").gsub(/[,]/, "")
                    itemImage  = ""
                    itemWebsite = "hofequipment"
                    itemName    = "vestil"

                    mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

                    if mymodel.empty?
                        p = Model.new
                        p.name    = itemName
                        p.url     = itemUrl
                        p.price   = itemPrice
                        p.image   = itemImage
                        p.website = itemWebsite
                        p.modelnumber = itemNumber
                        p.save
                    else

                        mymodel.first.price = itemPrice
                        mymodel.first.image = itemImage
                        mymodel.first.url = itemUrl
                        mymodel.first.website = itemWebsite
                        mymodel.first.save

                    end

                    puts itemName
                    puts itemUrl
                    puts itemPrice
                    puts itemImage
                    puts itemWebsite
                    puts itemNumber

                end
            elsif openpage.at(".item-price")

                itemNumber   = openpage.at(".sku-container .field-value").text.strip
                itemUrl    = openpage.uri
                itemPrice  = openpage.at(".item-price").text.strip
                itemImage  = ""
                itemWebsite = "hofequipment"
                itemName    = "vestil"

                mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

                if mymodel.empty?
                    p = Model.new
                    p.name    = itemName
                    p.url     = itemUrl
                    p.price   = itemPrice
                    p.image   = itemImage
                    p.website = itemWebsite
                    p.modelnumber = itemNumber
                    p.save
                else

                    mymodel.first.price = itemPrice
                    mymodel.first.image = itemImage
                    mymodel.first.url = itemUrl
                    mymodel.first.website = itemWebsite
                    mymodel.first.save

                end

                puts itemName
                puts itemUrl
                puts itemPrice
                puts itemImage
                puts itemWebsite
                puts itemNumber

            end
        end
    end

    def industrialsafety
        mechanize = Mechanize.new
		mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        page = mechanize.get("http://www.industrialsafety.com/searchresults.asp?searching=Y&sort=5&brand=Vestil&search=vestil&show=9718&page=1")

        elements = page.search(".v-product-grid a.v-product__img")

        elements.each do |product|
            mypage = mechanize.click(product)

            sleep(2)

            itemNumber      = mypage.at("i font span.product_code").text.gsub("VESTIL-", "")
            itemPrice       = mypage.at(".product_productprice b span[@itemprop='price']").text
            itemWebsite     = "industrialsafety"
            itemName        = "vestil"
            itemImage       = "image"
            itemUrl         = mypage.uri

            mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

            if mymodel.empty?
                p = Model.new
                p.name    = itemName
                p.url     = itemUrl
                p.price   = itemPrice
                p.image   = itemImage
                p.website = itemWebsite
                p.modelnumber = itemNumber
                p.save
            else

                mymodel.first.price = itemPrice
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save

            end

            puts itemNumber
            puts itemPrice
            puts itemImage
            puts itemName
            puts itemWebsite

        end

    end

    def toolfetch
        browser = Watir::Browser.new

        browser.goto('http://www.toolfetch.com/search?q=vestil#filter:brand:Vestil/perpage:100/sort:name:asc')

        mylinks = browser.links(:css => "a.product-image")

        mylinks.each do |x|
            browser.goto(x.href)

            itemName = "vestil"
            itemUrl = browser.url
            itemPrice = browser.element(css: 'span.price').text.strip.gsub(/[$]/, "").gsub(/[,]/, "")
            itemImage = ""
            itemWebsite = "toolfetch"
            itemNumber = browser.element(css: 'p.product-ids').text.strip.gsub("Part# VES-", "")

             mymodel = Model.where(modelnumber: itemNumber, website: itemWebsite)

             if mymodel.empty?
                 p = Model.new
                 p.name    = itemName
                 p.url     = itemUrl
                 p.price   = itemPrice
                 p.image   = itemImage
                 p.website = itemWebsite
                 p.modelnumber = itemNumber
                 p.save
             else
                 mymodel.first.price = itemPrice
                 mymodel.first.image = itemImage
                 mymodel.first.url = itemUrl
                 mymodel.first.website = itemWebsite
                 mymodel.first.save

             end

             puts itemName
             puts itemUrl
             puts itemPrice
             puts itemImage
             puts itemWebsite
             puts itemNumber

        end

        browser.close
    end

    def industrialproducts
        mechanize = Mechanize.new

        page = mechanize.get("http://www.industrialproducts.com/search/show/all?cat=0&q=vestil")

        urls = page.search("h2.product-name a")

        urls.each do |x|
            sleep(2)
            newpage = mechanize.click(x)

            table = newpage.at("#super-product-table tbody")

            if table

                table_data = table.search('tr').map do |row|
                    row.search('th, td').map { |cell| cell.text.strip }
                end

                table_data.each do |row|
                    puts row[0]
                    puts row[-2]
                end

            else
                price = newpage.at("span.map").text
                modelnumber = newpage.at("span.spn").text

                puts price
                puts modelnumber

            end

        end

    end
end

class Equipto
    include SuckerPunch::Job

    def perform(event)
    end

    def globalindustrial
        mechanize = Mechanize.new

        mechanize.user_agent_alias = 'Windows Chrome'

        (1..34).each do |x|

            vestil = mechanize.get("http://www.globalindustrial.com/shopByBrandName/E/equipto?cp=#{x}&ps=72")

            listitems = vestil.search(".grid .prod li .item a.ga_eecom")

            listitems.each do |x|
              begin
                page = mechanize.click(x)
              rescue Mechanize::ResponseCodeError => e
                page = mechanize.click(x + 1)
              end
                sleep(5)

                itemProductkey = page.at("#details .info .title").text.strip


                if page.at("#details .price span:nth-child(2)")
                    itemPrice = page.at("#details .price span:nth-child(2)").text.strip.gsub(/[,]/, "")
                elsif page.at(".price_breaks tbody tr td:nth-child(2)")
                    itemPrice = page.at(".price_breaks tbody tr td:nth-child(2)").text.strip
                end

                itemImage = page.at("#details div.enlarge img")['src']
                itemUrl = page.uri
                itemName = "equipto"
                itemWebsite = "globalindustrial"

                tableElement = page.search(".prodSpec ul ul li span")

                tableElement.each do |element|
                    if element.text == "MANUFACTURERS NUMBER"
                        number = tableElement.index(element) + 1
                        itemProductkey = tableElement[number].text
                    elsif element.text == "MANUFACTURERS PART NUMBER"
                        number = tableElement.index(element) + 1
                        itemProductkey = tableElement[number].text
                    end
                end

                puts itemImage
                puts itemProductkey
                puts itemPrice
                puts itemUrl
                puts itemName

                mymodel = Model.where(modelnumber: itemProductkey, name: itemName)

                if mymodel.empty?

                    p = Model.new

                    p.name          = itemName
                    p.modelnumber   = itemProductkey
                    p.price         = itemPrice
                    p.image         = itemImage
                    p.url           = itemUrl
                    p.website       = itemWebsite

                    p.save
                    puts "made and saved"
                else

                    mymodel.first.price = itemPrice
                    mymodel.first.image = itemImage
                    mymodel.first.url = itemUrl
                    mymodel.first.website = itemWebsite
                    mymodel.first.save

                    puts "did that stuff"

                end
            end
        end
    end

    def grainger
    end

    def hawkeye
        mechanize = Mechanize.new

        hawkeye = mechanize.get("http://www.hawkmat.com/brands/Equipto.html")

        webpage = hawkeye.search(".BlockContent .ProductList li .ProductImage a")

        webpage.each do |item|
            sleep(5)
            product = mechanize.click(item)

            itemPrice = product.at(".Value em.ProductPrice").text.strip.gsub("$", "").gsub(",", "")
            itemProductkey = product.at(".VariationProductSKU").text.strip
            itemName = "equipto"
            itemWebsite = "hawkeye"
            itemImage = ""
            itemUrl = product.uri

            mymodel = Model.where(modelnumber: itemProductkey, name: itemName)

            if mymodel.empty?

                p = Model.new

                p.name          = itemName
                p.modelnumber   = itemProductkey
                p.price         = itemPrice
                p.image         = itemImage
                p.url           = itemUrl
                p.website       = itemWebsite

                p.save
                puts "made and saved"
            else

                mymodel.first.price = itemPrice
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save

                puts "did that stuff"

            end


        end
    end

    def industrialproducts
        mechanize = Mechanize.new

        industrialproducts = mechanize.get("http://www.industrialproducts.com/search/manufacturer/equipto/show/all?cat=0&q=equipto")

        industrialproducts = industrialproducts.search(".catalogsearch-result-index .category-products .products-grid a.product-image")

        industrialproducts.each do |item|

            page = mechanize.click(item)

            sleep(5)

            itemPrice = page.at("span.map").text.gsub(/[$]/, "").gsub(/[,]/, "")
            itemProductkey = page.at(".product-ids").text.gsub("Product Code: ", "")
            itemName = "equipto"
            itemWebsite = "industrialproducts"
            itemUrl = page.uri
            itemImage = ""

            mymodel = Model.where(modelnumber: itemProductkey, name: itemName)

            if mymodel.empty?

                p = Model.new

                p.name          = itemName
                p.modelnumber   = itemProductkey
                p.price         = itemPrice
                p.image         = itemImage
                p.url           = itemUrl
                p.website       = itemWebsite

                p.save
                puts "made and saved"
            else

                mymodel.first.price = itemPrice
                mymodel.first.image = itemImage
                mymodel.first.url = itemUrl
                mymodel.first.website = itemWebsite
                mymodel.first.save

                puts "did that stuff"

            end

        end
    end
end
