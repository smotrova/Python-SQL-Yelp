--What are the top 5 states with the most 5 star businesses?
--yelp_business

select state, count(*) as count from yelp_business
group by state, stars
having stars=5
order by count DESC
limit 5;

--What are the top 5 cities with the most 5 star businesses?
-- yelp_business

select city, count(stars) as five_stars_count from yelp_business
group by city, stars
having stars = 5
order by five_stars_count DESC
limit 10; 

-- What are the top 5 businesses with the most reviews?
-- yelp_business

select name, count(review_count) as number_reviews from yelp_business
group by name
order by number_reviews desc
limit 5;

-- What are the top 5 category businesses most people review for?
-- yelp_business

select categories, count(review_count) as number_reviews from yelp_business
group by categories
order by number_reviews desc
limit 5;

-- What are the most one star review businesses from yelp?
-- yelp_business

select name, stars, max(review_count) from yelp_business
where stars = 1;

-- How many businesses are open?
-- yelp_business

select count(*) from yelp_business
where is_open = 1;

--What is the average stars of each states?

select state, avg(stars) from yelp_business
where regexp('[A-Z, a-z]', state)
group by state;

-- What are the top 5 businesses with the most check-ins?
-- yelp_checkin, yelp_business

select name from yelp_business as b
join (select business_id, count(checkins) as count from yelp_checkin
        group by business_id
        order by count desc
        limit 5) as c
on b.business_id = c.business_id;

-- How many 5 star reviews does Lo-Lo's Chicken & Waffles have?
-- Table: yelp_reviews

select count(*) from yelp_reviews
where stars = 5 and business_name = "Lo-Lo's Chicken & Waffles";

-- What was the business' name and review_text for the business that received the most cool number of votes
-- Table: yelp_reviews

select business_name, review_text from yelp_reviews
where cool = (select max(cool) from yelp_reviews);

-- What's the highest number of cool votes a review received?
-- Table: yelp_reviews

select max(cool) from yelp_reviews;

-- What is Lo-Lo's Chicken & Waffles star review breakdown?
-- Table: yelp_reviews

select stars, count(*) from yelp_reviews
where business_name = "Lo-Lo's Chicken & Waffles"
group by stars;

-- Replace the stars values that are text with integers
-- Table: yelp_reviews

select distinct cast(stars as integer) from yelp_reviews;
select cast(max(stars) as integer) from yelp_reviews;

-- Clean the data by removing the reviews with '?' for stars rating
-- Table: yelp_reviews

select * from yelp_reviews
where stars = '?';

delete from yelp_reviews
where stars = '?';

select distinct stars from yelp_reviews;

-- Make a breakdown by stars. How many entries are there per star?
-- Table: yelp_reviews

select stars, count(*) as count from yelp_reviews
group by stars
order by count desc;
