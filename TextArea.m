classdef TextArea < handle & CustomGuiInterface
    events
        ValueChangeEvent
    end
    
    methods
        function obj = TextArea()
            obj.uiInstance = uitextarea();
            obj.uiInstance.ValueChangedFcn = @(textarea, event) obj.textChangeCallback();
        end
        
        %
        % Setters for all TextField properties
        %
        function obj = setBackgroundColor(obj, color)
            obj.uiInstance.BackgroundColor = color;
        end
        
        function obj = setText(obj, text)
            obj.uiInstance.String = text;
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
        
        function obj = addValueChangeListener(obj, callbackHandle)
            addlistener(obj, 'ValueChangeEvent', callbackHandle)
        end
    end
    
    methods (Access = private)
        function obj = textChangeCallback(obj)
            notify(obj, 'ValueChangeEvent');
        end
    end
end

