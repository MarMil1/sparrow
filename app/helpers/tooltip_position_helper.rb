module TooltipPositionHelper
    def tooltip_left
        "w-max left-0 top-1/2 transform -translate-x-full -translate-y-1/2"
    end

    def tooltip_top_left
        "w-max left-0 top-1/2 transform -translate-x-full -translate-y-full"
    end

    def tooltip_bottom_left
        "w-max bottom-0 left-1/2 transform translate-y-full -translate-x-full"
    end

    def tooltip_right
        "w-max right-0 top-1/2 transform translate-x-full -translate-y-1/2"
    end

    def tooltip_top_right
        "w-max right-0 top-1/2 transform translate-x-full -translate-y-full"
    end

    def tooltip_bottom_right
        "w-max bottom-0 left-1/2 transform translate-y-full"
    end

    def tooltip_top
        "w-max top-0 left-1/2 transform -translate-y-full -translate-x-1/2"
    end
    
    def tooltip_bottom
        "w-max bottom-0 left-1/2 transform translate-y-full -translate-x-1/2"
    end
end