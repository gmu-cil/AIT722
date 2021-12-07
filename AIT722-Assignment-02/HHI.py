{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "e65d1f41",
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import numpy as np"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "id": "5663f4bb",
   "metadata": {},
   "outputs": [],
   "source": [
    "# df = pd.read_csv (r'~/Assignment 2 - AIT722/Meetup_Final_Data.csv')\n",
    "df = pd.read_csv(r'~/Assignment 2 - AIT722/Meetup_Final_Data.csv', usecols = ['city', 'topic'])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 45,
   "id": "1111ef92",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "        topic         city\n",
      "0        Arts  Great Falls\n",
      "1        Food    Arlington\n",
      "2       Local       Reston\n",
      "3    Wellness        Bowie\n",
      "4     Hobbies   Alexandria\n",
      "..        ...          ...\n",
      "158      Food   Washington\n",
      "159      Arts     Sterling\n",
      "160  Wellness   Washington\n",
      "161      Arts   Washington\n",
      "162      Food    Arlington\n",
      "\n",
      "[163 rows x 2 columns]\n"
     ]
    }
   ],
   "source": [
    "print (df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "id": "eba34b57",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "            city     topic\n",
      "0    Great Falls      Arts\n",
      "1      Arlington      Food\n",
      "2         Reston     Local\n",
      "3          Bowie  Wellness\n",
      "4     Alexandria   Hobbies\n",
      "..           ...       ...\n",
      "158   Washington      Food\n",
      "159     Sterling      Arts\n",
      "160   Washington  Wellness\n",
      "161   Washington      Arts\n",
      "162    Arlington      Food\n",
      "\n",
      "[163 rows x 2 columns]\n"
     ]
    }
   ],
   "source": [
    "#Switching the topic and city, because I can?\n",
    "cols = df.columns.tolist()\n",
    "cols = cols[-1:] + cols[:-1]\n",
    "df = df[cols]\n",
    "print (df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "id": "aacf83c8",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th>city</th>\n",
       "      <th>topic</th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>count</th>\n",
       "      <td>163</td>\n",
       "      <td>163</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>unique</th>\n",
       "      <td>34</td>\n",
       "      <td>5</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>top</th>\n",
       "      <td>Washington</td>\n",
       "      <td>Wellness</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>freq</th>\n",
       "      <td>57</td>\n",
       "      <td>59</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "              city     topic\n",
       "count          163       163\n",
       "unique          34         5\n",
       "top     Washington  Wellness\n",
       "freq            57        59"
      ]
     },
     "execution_count": 47,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df.describe()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a74cc099",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 48,
   "id": "8159d73b",
   "metadata": {},
   "outputs": [],
   "source": [
    "#fdf = df.loc [ df['topic'] == 'Hobbies' ]\n",
    "#fdf.count()\n",
    "#print(fdf)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "id": "952c66d9",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Create a series / list of all cities"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 50,
   "id": "361515e0",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Create a dictionary of the form: [CITY: [num0, num1, num2, num3, num4 ] ]... a city to 5-vector for each of the topics - Arts, Food, Hobbies, Local, Wellness.\n",
    "# To do this, for each city then create the vector; alternative is to do this and next step in one set of actions\n",
    "\n",
    "# Looking at Pandas documentation, crosstab and categorical data entries look promising:\n",
    "# https://pandas.pydata.org/docs/user_guide/reshaping.html#cross-tabulations\n",
    "# https://pandas.pydata.org/docs/user_guide/reshaping.html#reshaping-tile-cut"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 51,
   "id": "3c87f458",
   "metadata": {},
   "outputs": [],
   "source": [
    "# pd.cut(['city'], bins = ['Arts', 'Food','Hobbies', 'Local', 'Wellness'])\n",
    "\n",
    "topics = pd.Series(['Arts', 'Food','Hobbies', 'Local', 'Wellness'], dtype=\"category\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 73,
   "id": "3c04ee83",
   "metadata": {},
   "outputs": [],
   "source": [
    "topics  ## this is an ndarray / series (numpy)\n",
    "topics_list = topics.tolist()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 53,
   "id": "24fa01ea",
   "metadata": {},
   "outputs": [],
   "source": [
    "cities = df.groupby ([\"city\"]).agg([np.size])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 54,
   "id": "e0bacbb2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead tr th {\n",
       "        text-align: left;\n",
       "    }\n",
       "\n",
       "    .dataframe thead tr:last-of-type th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr>\n",
       "      <th></th>\n",
       "      <th>topic</th>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th></th>\n",
       "      <th>size</th>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>city</th>\n",
       "      <th></th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>Alexandria</th>\n",
       "      <td>10</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Annandale</th>\n",
       "      <td>4</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Arlington</th>\n",
       "      <td>16</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Bethesda</th>\n",
       "      <td>4</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Bowie</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Brentwood</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Centreville</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Chantilly</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Chevy Chase</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>College Park</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Columbia</th>\n",
       "      <td>9</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Fairfax</th>\n",
       "      <td>8</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Falls Church</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Gaithersburg</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Great Falls</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Greenbelt</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Herndon</th>\n",
       "      <td>2</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Manassas</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>McLean</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Oakton</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Odenton</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Olney</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Oxon Hill</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Reston</th>\n",
       "      <td>6</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Rockville</th>\n",
       "      <td>6</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Severn</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Silver Spring</th>\n",
       "      <td>6</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Springfield</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Sterling</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Timonium</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Tysons Corner</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Vienna</th>\n",
       "      <td>3</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Washington</th>\n",
       "      <td>57</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>Woodbridge</th>\n",
       "      <td>1</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "              topic\n",
       "               size\n",
       "city               \n",
       "Alexandria       10\n",
       "Annandale         4\n",
       "Arlington        16\n",
       "Bethesda          4\n",
       "Bowie             1\n",
       "Brentwood         1\n",
       "Centreville       1\n",
       "Chantilly         1\n",
       "Chevy Chase       1\n",
       "College Park      1\n",
       "Columbia          9\n",
       "Fairfax           8\n",
       "Falls Church      3\n",
       "Gaithersburg      1\n",
       "Great Falls       3\n",
       "Greenbelt         1\n",
       "Herndon           2\n",
       "Manassas          1\n",
       "McLean            1\n",
       "Oakton            3\n",
       "Odenton           1\n",
       "Olney             1\n",
       "Oxon Hill         1\n",
       "Reston            6\n",
       "Rockville         6\n",
       "Severn            1\n",
       "Silver Spring     6\n",
       "Springfield       3\n",
       "Sterling          3\n",
       "Timonium          1\n",
       "Tysons Corner     1\n",
       "Vienna            3\n",
       "Washington       57\n",
       "Woodbridge        1"
      ]
     },
     "execution_count": 54,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "cities"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 55,
   "id": "cc0c31b9",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "city ('topic', 'size')\n"
     ]
    }
   ],
   "source": [
    "# for each city, create a 5-vector and stick the pair into a dictionary:\n",
    "for city in cities:\n",
    "    print(\"city\", city)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 56,
   "id": "da2f3cef",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "            city     topic\n",
      "0    Great Falls      Arts\n",
      "1      Arlington      Food\n",
      "2         Reston     Local\n",
      "3          Bowie  Wellness\n",
      "4     Alexandria   Hobbies\n",
      "..           ...       ...\n",
      "158   Washington      Food\n",
      "159     Sterling      Arts\n",
      "160   Washington  Wellness\n",
      "161   Washington      Arts\n",
      "162    Arlington      Food\n",
      "\n",
      "[163 rows x 2 columns]\n"
     ]
    }
   ],
   "source": [
    "print(df)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 67,
   "id": "263f7fcb",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "['Alexandria' 'Annandale' 'Arlington' 'Bethesda' 'Bowie' 'Brentwood'\n",
      " 'Centreville' 'Chantilly' 'Chevy Chase' 'College Park' 'Columbia'\n",
      " 'Fairfax' 'Falls Church' 'Gaithersburg' 'Great Falls' 'Greenbelt'\n",
      " 'Herndon' 'Manassas' 'McLean' 'Oakton' 'Odenton' 'Olney' 'Oxon Hill'\n",
      " 'Reston' 'Rockville' 'Severn' 'Silver Spring' 'Springfield' 'Sterling'\n",
      " 'Timonium' 'Tysons Corner' 'Vienna' 'Washington' 'Woodbridge']\n"
     ]
    }
   ],
   "source": [
    "#Get a list of the cities?\n",
    "#then, for each dictionary entry: select count(*) from df where city = <current dictionary entry>\n",
    "# e.g., --> {\"Centreville\": [0,0,2,1,0]}\n",
    "cities_ndarray = df['city'].unique()\n",
    "cities_ndarray.sort()\n",
    "print(cities_ndarray)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 71,
   "id": "b4a4627d",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "34\n",
      "Alexandria\n",
      "Annandale\n",
      "Arlington\n",
      "Bethesda\n",
      "Bowie\n",
      "Brentwood\n",
      "Centreville\n",
      "Chantilly\n",
      "Chevy Chase\n",
      "College Park\n",
      "Columbia\n",
      "Fairfax\n",
      "Falls Church\n",
      "Gaithersburg\n",
      "Great Falls\n",
      "Greenbelt\n",
      "Herndon\n",
      "Manassas\n",
      "McLean\n",
      "Oakton\n",
      "Odenton\n",
      "Olney\n",
      "Oxon Hill\n",
      "Reston\n",
      "Rockville\n",
      "Severn\n",
      "Silver Spring\n",
      "Springfield\n",
      "Sterling\n",
      "Timonium\n",
      "Tysons Corner\n",
      "Vienna\n",
      "Washington\n",
      "Woodbridge\n"
     ]
    }
   ],
   "source": [
    "# For each city, how many of each topic? --> put in a dictionary format of\n",
    "#cities_ndaray?  ## THIS IS AN NDARRAY type from numpy\n",
    "cities_list = cities_ndarray.tolist()\n",
    "# n = len(cities_list)\n",
    "# print (n)\n",
    "# for city in cities_list:\n",
    "#    print(city)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 76,
   "id": "855b512a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "{'Alexandria': [0, 0, 0, 0, 0], 'Annandale': [0, 0, 0, 0, 0], 'Arlington': [0, 0, 0, 0, 0], 'Bethesda': [0, 0, 0, 0, 0], 'Bowie': [0, 0, 0, 0, 0], 'Brentwood': [0, 0, 0, 0, 0], 'Centreville': [0, 0, 0, 0, 0], 'Chantilly': [0, 0, 0, 0, 0], 'Chevy Chase': [0, 0, 0, 0, 0], 'College Park': [0, 0, 0, 0, 0], 'Columbia': [0, 0, 0, 0, 0], 'Fairfax': [0, 0, 0, 0, 0], 'Falls Church': [0, 0, 0, 0, 0], 'Gaithersburg': [0, 0, 0, 0, 0], 'Great Falls': [0, 0, 0, 0, 0], 'Greenbelt': [0, 0, 0, 0, 0], 'Herndon': [0, 0, 0, 0, 0], 'Manassas': [0, 0, 0, 0, 0], 'McLean': [0, 0, 0, 0, 0], 'Oakton': [0, 0, 0, 0, 0], 'Odenton': [0, 0, 0, 0, 0], 'Olney': [0, 0, 0, 0, 0], 'Oxon Hill': [0, 0, 0, 0, 0], 'Reston': [0, 0, 0, 0, 0], 'Rockville': [0, 0, 0, 0, 0], 'Severn': [0, 0, 0, 0, 0], 'Silver Spring': [0, 0, 0, 0, 0], 'Springfield': [0, 0, 0, 0, 0], 'Sterling': [0, 0, 0, 0, 0], 'Timonium': [0, 0, 0, 0, 0], 'Tysons Corner': [0, 0, 0, 0, 0], 'Vienna': [0, 0, 0, 0, 0], 'Washington': [0, 0, 0, 0, 0], 'Woodbridge': [0, 0, 0, 0, 0]}\n"
     ]
    }
   ],
   "source": [
    "## SOOO... now we have a list of cities and a list of topics: cities_list and topics_list.\n",
    "city_dict = {} # empty it, especially in a jupyter environment\n",
    "for city in cities_list:\n",
    "    #for topic in topics_list:\n",
    "    city_dict [city] = [0,0,0,0,0]\n",
    "print (city_dict) # here you have 5-vector bins for all the cities that are blank."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 77,
   "id": "908b424d",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "{'Alexandria': [2, 2, 2, 2, 2], 'Annandale': [2, 2, 2, 2, 2], 'Arlington': [2, 2, 2, 2, 2], 'Bethesda': [2, 2, 2, 2, 2], 'Bowie': [2, 2, 2, 2, 2], 'Brentwood': [2, 2, 2, 2, 2], 'Centreville': [2, 2, 2, 2, 2], 'Chantilly': [2, 2, 2, 2, 2], 'Chevy Chase': [2, 2, 2, 2, 2], 'College Park': [2, 2, 2, 2, 2], 'Columbia': [2, 2, 2, 2, 2], 'Fairfax': [2, 2, 2, 2, 2], 'Falls Church': [2, 2, 2, 2, 2], 'Gaithersburg': [2, 2, 2, 2, 2], 'Great Falls': [2, 2, 2, 2, 2], 'Greenbelt': [2, 2, 2, 2, 2], 'Herndon': [2, 2, 2, 2, 2], 'Manassas': [2, 2, 2, 2, 2], 'McLean': [2, 2, 2, 2, 2], 'Oakton': [2, 2, 2, 2, 2], 'Odenton': [2, 2, 2, 2, 2], 'Olney': [2, 2, 2, 2, 2], 'Oxon Hill': [2, 2, 2, 2, 2], 'Reston': [2, 2, 2, 2, 2], 'Rockville': [2, 2, 2, 2, 2], 'Severn': [2, 2, 2, 2, 2], 'Silver Spring': [2, 2, 2, 2, 2], 'Springfield': [2, 2, 2, 2, 2], 'Sterling': [2, 2, 2, 2, 2], 'Timonium': [2, 2, 2, 2, 2], 'Tysons Corner': [2, 2, 2, 2, 2], 'Vienna': [2, 2, 2, 2, 2], 'Washington': [2, 2, 2, 2, 2], 'Woodbridge': [2, 2, 2, 2, 2]}\n"
     ]
    }
   ],
   "source": [
    "## For each city in the dictionary, update the bins with the count for each topic\n",
    "for city in cities_list:\n",
    "    # Topics = arts, food, hobbies, local, wellness\n",
    "    count_arts = 2\n",
    "    count_food = 2\n",
    "    count_hobbies = 2\n",
    "    count_local = 2\n",
    "    count_wellness = 2\n",
    "    city_dict [city] = [count_arts, count_food, count_hobbies, count_local, count_wellness]\n",
    "print(city_dict)\n",
    "    "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "f085745c",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.8.8"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
