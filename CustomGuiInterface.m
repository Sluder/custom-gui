classdef (Abstract) CustomGuiInterface < handle
    properties (Access = protected)
        uiInstance
        
        text
        backgroundColor
        
        fontColor
        fontName
        fontWeight
        fontAngle
        fontSize
    end
    
    methods (Abstract)
        setText(obj, text);
        setBackgroundColor(obj, color);
        setFontColor(obj, color);
        setFontName(obj, fontName);
        setFontWeight(obj, weight);
        setFontAngle(obj, angle);
        setFontSize(obj, size);
    end
end

