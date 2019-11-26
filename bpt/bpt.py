#!/usr/bin/python3

# bpt.py
# Note: use Python 3
# Simple B+ Tree in memory
# See section 14.3
# Keys are strings, values are numeric (i.e. pointers to records in a disk file)

from bisect import bisect_left, bisect_right
from random import randint, seed

# Helpful Notes:
# Python array slices: https://www.pythoncentral.io/how-to-slice-listsarrays-and-tuples-in-python/
# Bisect module: https://docs.python.org/3.8/library/bisect.html

# Look for *** your code goes here ***

class BPlusTree(object):
    def __init__(self, n):
        """
        Create an empty B+ tree.
        A node has n-1 keys and n pointers. Leaf nodes have n keys.
        """
        #            BPlusLeafNode(keys, values, next_leaf, n)
        self._root = BPlusLeafNode([], [], None, n-1)
        self._size = n-1

    def insert(self, key, value):
        """ Insert a key and value"""
        pkey, ppointer = self._root.insert(key, value)
        if pkey is not None:
            #          BPlusNode(keys,   pointers,               n)
            new_node = BPlusNode([pkey], [self._root, ppointer], self._size)
            self._root = new_node

    def keys(self):
        """ Get all keys in node """
        return self._root.keys()

    def find(self, key):
        """ Return value for key in this node, None if not present """
        return self._root.find(key)

    def find_range(self, lb, ub):
        resultset = []

        # You must implement this method
        # *** Your code goes here ***

        return resultset

    def num_keys(self):
        """ Get number of keys """
        return self._root.num_keys()

    def height(self):
        """ Get height of the subtree """
        return self._root.height() + 1

    def display(self):
        """
        Output a crude visual representation of the tree.
        """
        # Breadth-first traversal of the tree
        def print_level(node, level):
            if level == 1:
                print(str(node) + ' ', end='')
            elif level > 1: 
                for p in node._ptrs:
                    print_level(p, level - 1)
        
        # Levels
        for level in range(1, self.height() + 1):
            # Handle leaf nodes separately
            if level != self.height():
                # Recursion for root and internal nodes
                print_level(self._root, level)
            else:
                leaf = self._root._ptrs[0]
                for i in range(self.height() - 2):
                    leaf = leaf._ptrs[0]
                output = ""
                while leaf._next is not None:
                    output += str(leaf) + " -> "
                    leaf = leaf._next
                output += str(leaf)
                print (output)

            print()

class BPlusNode(object):
    def __init__(self, keys, pointers, n):
        """
        Create a new BPlusNode.
        We have keys k(0), k(1), ..., k(n) and pointers p(0), p(1), ..., p(n+1)
        """
        self._keys = keys
        self._ptrs = pointers
        self._size = n

    def keys(self):
        """ Get all keys in subtree """
        return self._ptrs[0].keys()

    def find(self, key):
        """ Return value for this key, None if not found """
        #print ("Looking for {0} in {1}".format(key, self._keys))
        return self._ptrs[bisect_right(self._keys, key)].find(key)

    def insert_at(self, pos, key, pointer):
        """
        Insert a key and pointer at pos.
        return (None, None) if nothing to promote.
        return new node if node splits.
        """
        self._keys.insert(pos, key)
        self._ptrs.insert(pos + 1, pointer)

        cap = self._size
        split_idx = (cap + 1) // 2    # integer division

        # Do we need to split?
        if len(self._keys) > cap:
            pkey = self._keys[split_idx]
            self._keys.remove(pkey)
            #          BPlusNode(keys,                   pointers,                       n)
            new_node = BPlusNode(self._keys[split_idx:], self._ptrs[split_idx + 1:], cap)
            self._keys = self._keys[:split_idx]
            self._ptrs = self._ptrs[:split_idx + 1]            
            # Return new node
            return (pkey, new_node)
        return (None, None)

    def insert(self, key, value):
        """
        Insert a key into this subtree
        Return (None, None) if there is nothing to promote
        Return (pkey, ppointer) if node splits 
        """
        # Find where to insert
        (pkey, ppointer) = self._ptrs[bisect_right(self._keys, key)].insert(key, value)

        # Promote key if needed
        if pkey is not None:
            pos = bisect_left(self._keys, pkey)
            (promoted_key, new_node) = self.insert_at(pos, pkey, ppointer)
            return (promoted_key, new_node)
        return (None, None)

    def num_keys(self):
        """ Count keys in leaf nodes """
        # Map num_keys() to each child node then sum the results
        return sum(map(lambda n: n.num_keys(), self._ptrs))

    def height(self):
        """ Get height of subtree """
        return self._ptrs[0].height() + 1

    def __str__(self):
        return str(self._keys)


class BPlusLeafNode(object):
    def __init__(self, keys, values, next_leaf, n):
        """ Create a leaf node """
        self._keys = keys
        self._values = values
        self._next = next_leaf  # points to next leaf node to right
        self._size = n

    def keys(self):
        """ 
        Get keys from here to the end of the linked list of leaf nodes.
        Note that this could be a lot of data for a large tree.
        """
        _keys = []
        # Get keys in this node
        for k in self._keys:
            _keys.append(k)
        current = self
        # Add keys from remaining nodes
        while current._next is not None:
            current = current._next
            _keys.extend(current._keys)  
        return _keys

    def find(self, key):
        """ Return the value for a key, None if not found """
        try:
            i = self._keys.index(key)
            return self._values[i]
        except ValueError:
            return None

    def find_range(self, lb, ub):
        resultset = []

        # This might be a good place to implement most of your 'range find' functionality
        # *** your code goes here ***

        return resultset


    def insert(self, key, value):
        """
        Insert key into the node.
        Return (None, None) if there is nothing to promote
        Return new node if node splits.
        """
        # Find where to insert
        index = bisect_left(self._keys, key)
        if index == len(self._keys) or self._keys[index] != key:
            self._keys.insert(index, key)
            self._values.insert(index, value)

        cap = self._size
        split_index = (cap+1) // 2   # integer division 

        # Do we need a new leaf node?
        if len(self._keys) > cap:
            new_leaf = BPlusLeafNode(self._keys[split_index:], self._values[split_index:], self._next, cap)
            self._keys = self._keys[:split_index]
            self._next = new_leaf
            return (new_leaf._keys[0], new_leaf)
        return (None, None)

    def num_keys(self):
        """ Get number of keys """
        return len(self._keys)

    def height(self):
        """ Get height of subtree """
        return 0

    def __str__(self):
        return str(self._keys)


# Main program
if __name__ == '__main__':
    # Initialize PRNG
    seed(737)
    
    # Build a tree
    tree = BPlusTree(4)
    data = ['Srinivasan', 'Wu', 'Mozart', 'Einstein', 'El Said', 'Gold',
            'Katz', 'Califieri', 'Singh', 'Crick', 'Brandt', 'Kim']
    
    for item in data:
        # Insert key and a random 'record pointer', which, if this were real,
        # would point to a record in a disk file
        tree.insert(item, randint(0, 1000))

    # Display the tree
    tree.display()

    # Find and display a (key, value)
    print ("Gold's data is at record number {0}".format(tree.find("Gold")))
