classdef Label < CustomGuiInterface
    properties
        enabled
    end
    
    methods
        function obj = Label()
            obj.uiInstance = uilabel();
        end
        %
        % Setters for all Label properties
        %
        function obj = setText(obj, text)
            obj.uiInstance.Text = text;
        end
        
        function obj = setBackgroundColor(obj, color)
            obj.uiInstance.BackgroundColor = color;
        end
        
        function obj = setFontColor(obj, color)
            obj.uiInstance.FontColor = color;
        end
        
        function obj = setFontName(obj, fontName)
            obj.uiInstance.FontName = fontName;
        end
        
        function obj = setFontWeight(obj, weight)
            obj.uiInstance.FontWeight = weight;
        end
        
        function obj = setFontAngle(obj, angle)
            obj.uiInstance.FontAngle = angle;
        end
        
        function obj = setFontSize(obj, size)
            obj.uiInstance.FontSize = size;
        end
        
        function obj = setEnabled(obj, isEnabled)
            obj.uiInstance.uiInstance.Enable = isEnabled;
        end
    end
end

