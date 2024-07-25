json.cache! ['talents', @talents], expires_in: 5.minutes do
 json.array! @talents, partial: "v1/talents/talent", as: :talent
end
