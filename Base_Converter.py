# ver. Fri/23/Feb/2024
#
# Made by: CyberCoral
# ------------------------------------------------
# Github:
# https://www.github.com/CyberCoral
#

# The only use of sys.
import sys

sys.set_int_max_str_digits(1000000000)


###
### An auxiliary function to create dictionaries.
###

def MakeStandardDict(lista: list):
    '''
    This program returns a dictionary
    which depend on the list introduced,
    that can be used in this program.
    '''
    if isinstance(lista, list) != True:
        raise SyntaxError("The variable lista must be a list.")
    return {str(lista[i]):i for i in range(len(lista))}

###
### The default list and dict.
###

alph3 = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
       "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T",
       "U","V","W","X","Y","Z","_"," "]
equivalencia = MakeStandardDict(alph3)


### 
### The converter function.
###

def GeneralBaseConverter(num, original_base: int ,final_base: int, dictio: dict = equivalencia, lista: list = alph3):
    '''
    It converts any number of any original_base
    to another final_base, given the dictio dict
    and the lista list.
    '''

    # Error handling, not totally necessary.
    
    if isinstance(original_base, int) != True:
        raise TypeError("The base has to be an integer.")
    elif original_base < 2:
        raise ValueError("The base must be greater or equal than 2.")

    if isinstance(final_base, int) != True:
        raise TypeError("The base has to be an integer.")
    elif final_base < 2:
        raise ValueError("The base must be greater or equal than 2.")

    if isinstance(dictio, dict) != True:
        raise TypeError("The variable dictio must be a dict.")
    elif len(list(dictio.keys())) < max([original_base, final_base]):
        raise IndexError("There has to be more elements in the dict than the base.")
    elif sum([list(dictio.keys()).count(list(dictio.keys())[i]) for i in range(len(list(dictio.keys())))]) != len(list(dictio.keys())):
        raise ValueError("There must not be copies of the same element in the dict.")

    if isinstance(lista, list) != True:
        raise TypeError("The variable list must be a list.")
    elif len(lista) < max([original_base, final_base]):
        raise IndexError("There has to be more elements in the list than the base.")
    elif sum([lista.count(lista[i]) for i in range(len(lista))]) != len(lista):
        raise ValueError("There must not be copies of the same element in the list.")

    def BaseToDecimal(num, base: int, lista: list = alph3, dictio: dict = equivalencia):
        '''
        It transforms a number in any base
        to decimal, given the dictionary dictio.
        '''

        lista1 = []

        string2 = (",".join(str(num))).split(",")[::-1]
        
        for con in range(len(string2)):
            if string2[con] in dictio:
                lista1.append(dictio[string2[con]])      
            else:
                raise IndexError("The dictionary used doesn't contain the character {} in the number.".format(string2[con]))    
        
        #####
        ##### Check if number "num" is in base "base" by checking each element.
        #####
        
        for elem in range(len(num)):
            if int(lista1[elem]) >= base:
                raise SyntaxError("Element given ({}) is not in base {}, try again with other base.".format(int(num[elem]), base))

        return sum([int(lista1[k]) * base ** k for k in range(len(lista1))])


    def DecimalToBase(num, base: int, lista: list = alph3, dictio: dict = equivalencia):
        '''
        It converts a number in decimal form
        to any base, given the dictionary dictio
        and the list lista.
        ''' 

        lista_inf = []
        
        #####
        ##### This process is the reverse to Base2Decimal's, as it is used to know which character
        ##### or number is equivalent to from decimal to other bases.
        #####

        num = int(num)
        
        while num >= 1:              
            lista_inf.append(lista[num % base])
            num //= base
            
        lista_inf = "".join(lista_inf[::-1])

        for elem in range(0,len(lista_inf)):
            element = dictio[lista_inf[int(elem)]]
            if int(element) >= base:
                raise SyntaxError("Element given ({}) is not in base {}, try again with other base.".format(element, base))

        return lista_inf
            
    num = str(num)
             
    ###
    ### Main conversion section.
    ###

    num = BaseToDecimal(num, original_base, lista, dictio)
    result = DecimalToBase(num,final_base, lista, dictio)  
    return result
