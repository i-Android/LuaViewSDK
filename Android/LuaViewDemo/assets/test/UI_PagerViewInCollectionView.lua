--工具包引入
require "kit/lv_kit"

w, h = System.screenSize()

cellHeight = 100
imageUrl1 = "http://gju2.alicdn.com/bao/uploaded/i1/10000073270926575/TB2fpg0cXXXXXb6XpXXXXXXXXXX_!!0-0-juitemmedia.jpg"
imageUrl2 = "http://img4.duitang.com/uploads/item/201306/25/20130625045508_sairr.thumb.600_0.jpeg"


local vp = PagerView({
    PageCount = 4,
    Pages = {
        Title = function(pos)
            return "Title"
        end,
        Init = function(page, pos)
            local tableView = RefreshCollectionView {
                Section = {
                    SectionCount = 2,
                    RowCount = function(section)
                        if(section == 1) then
                            return 1
                        else
                            return 10
                        end
                    end
                },
                Cell = {
                    Id = function(section, row)
                        if(pos % 2 == 0) then
                            if (section == 1) then
                                return "HScroll"
                            else
                                return "ImageAndImage"
                            end
                        else
                            if (section == 1) then
                                return "Pager"
                            else
                                return "ImageAndImage"
                            end
                        end
                    end,
                    HScroll = {
                        Size = function(section, row)
                            return w, 100
                        end,
                        Init = function(cell, section, row)
                            local scrollView = HScrollView()
                            for i = 0, 10, 1 do
                                local btn = Label()
                                btn.text("BTN" .. i)
                                btn.frame(i * 80, 0, 79, 100)
                                btn.backgroundColor(0xff00ff00)
                                scrollView.addView(btn)
                            end
                            scrollView.size(w, 100)
                            scrollView.backgroundColor(0xffcccccc)
                            cell.container= scrollView
                        end,
                        Layout = function(cell, section, row)
                        end
                    },
                    Pager = {
                        Size = function(section, row)
                            return w, 100
                        end,
                        Init = function(cell, section, row)
                            local vp = PagerView({
                                PageCount = 10,
                                Pages = {
                                    Title = function(pos)
                                        return "Title"
                                    end,
                                    Init = function(page, pos)
                                        page.icon = Button()
                                    end,
                                    Layout = function(page, pos)
                                        page.icon.text("测试按钮"..pos)
                                        page.icon.frame(0, 0, w, 100)
                                    end
                                }
                            })

                            vp.backgroundColor(0xaaaa0000)
                            vp.frame(0, 0, w, 100)

                            cell.container = vp
                        end,
                        Layout = function(cell, section, row)
                        end
                    },
                    ImageAndImage = {
                        Size = function(section, row)
                            return cellHeight
                        end,
                        Init = function(cell, section, row)
                            cell.icon = Image()
                            cell.icon2 = Image()
                        end,
                        Layout = function(cell, section, row)
                            local cellWdith, cellHeight = cell.window.size()
                            cell.icon.frame(0, 0, cellHeight, cellHeight)
                            cell.icon.image(imageUrl1, function()
                                print("imageLoaded-ImageAndImage-1", section, row)
                            end)


                            cell.icon2.frame(cellHeight + 10, 0, cellHeight, cellHeight)
                            cell.icon2.image(imageUrl1, function()
                                print("imageLoaded-ImageAndImage-2", section, row)
                            end)
                        end
                    }
                }
            }
            tableView.frame(0, 0, w, h - 64)

            page.view = tableView

        end,
        Layout = function(page, pos)
        end
    }
})

vp.backgroundColor(0xaaaa0000)
vp.frame(0, 0, w, h)






