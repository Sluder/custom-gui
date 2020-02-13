classdef Validator < handle
    % Possible rules delimited by '|'
    % numeric   : Must be a number
    % string    : Must be of type string
    % char      : Must be of type char
    % required  : Must not be empty
    % optional  : Nullable, but checked when other rules are provided
    % regex     : Must match regex
    % not_regex : Must not match regex
    % contains  : Must be string/char, and contain a certain word
    % min       : Min value for a number, or string/char length
    % max       : Max value for a number, or string/char length
    %
    % Example : 'min:5|contains:text'
    
    methods (Static)
        function [passedRules, failedRule] = validate(value, rules)
            passedRules = true;
            functionHandles = containers.Map({
                'numeric'
                'string'
                'char'
                'required'
                'regex'
                'notRegex'
                'contains'
                'min'
                'max'
            }, {
                @isNumeric
                @isString
                @isChar
                @notEmpty
                @regex
                @notRegex
                @strContains
                @min
                @max
            });
        
            rules = split(rules, '|');
            
            for i = 1:numel(rules)
                rule = rules{i};
                
                % Only continue if optional field has rules when not empty
                if isequal(rule, 'optional')
                    if isempty(value)
                        return
                    else
                        continue
                    end
                end
                
                % Handle rules like 'min:5'
                if contains(rule, ':')
                    specialRule = split(rule, ':');
                    rule = specialRule{1};
                    param = specialRule{2};
                    
                    functionHandle = functionHandles(rule);
                    passedRules = functionHandle(value, param);
                % Handle normal rules like 'numeric'
                else
                    functionHandle = functionHandles(rule);
                    passedRules = functionHandle(value);
                end
                
                % Exit if any rules fail, and replay with failed rule
                if ~passedRules
                    failedRule = rule;
                    return
                end
            end
        end
    end
end

% 
% Functions able to be called from validate()
%
function passed = isNumeric(value)
    passed = isnumeric(value);
end

function passed = isString(value)
    passed = isstring(value);
end

function passed = isChar(value)
    passed = ischar(value);
end

function passed = notEmpty(value)
    passed = ~isempty(value);
end

function passed = regex(value)
    expression = split(rule, ':');
    passed = regex_match(value, expression);
end

function passed = notRegex(value)
    expression = split(rule, ':');
    passed = ~regex_match(value, expression);
end

function passed = strContains(value)     
    word = split(rule, ':');
    passed = (isstring(value) || ischar(value)) && contains(value, word{2});
end

function passed = min(value, min)
    passed = false;
    
    if ischar(value) || isstring(value)
        passed = strlength(value) >= str2double(min);
    elseif isnumeric(value)
        passed = value >= str2double(min);
    end
end

function passed = max(value, max)
    passed = false;

    if ischar(value) || isstring(value)
        passed = strlength(value) <= str2double(max);
    elseif isnumeric(value)
        passed = value <= str2double(max);
    end
end